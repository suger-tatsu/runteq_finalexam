class GroupAssignmentsController < ApplicationController
  before_action :set_current_teacher

  def index
    if params[:q].present?
      @group_assignments = current_teacher.group_assignments.where("title ILIKE ?", "%#{params[:q]}%")
    else
      @group_assignments = current_teacher.group_assignments
    end
  end

  def autocomplete
    titles = GroupAssignment.where("title ILIKE ?", "%#{params[:q]}%").limit(10).pluck(:title)
    render json: titles
  end

  def new
    @group_assignment = GroupAssignment.new
    @students = current_teacher.students
    @skills = current_teacher.skills
  end

  def create
    @group_assignment = GroupAssignment.new_from_params(group_assignment_params, @current_teacher)

    if @group_assignment.save_and_assign_groups
      redirect_to group_assignments_path, notice: "グループ分けを作成しました"
    else
      Rails.logger.error("保存失敗: #{@group_assignment.errors.full_messages.join(', ')}")
      flash.now[:alert] = @group_assignment.errors.full_messages.join(', ')
      @students = current_teacher.students
      @skills = current_teacher.skills
      render :new
    end
  end

  def show
    @group_assignment = GroupAssignment.find(params[:id])
    @groups = @group_assignment.groups.includes(:students)
  end

  def destroy
    @group_assignment = GroupAssignment.find(params[:id])
    @group_assignment.destroy
    redirect_to group_assignments_path, notice: '削除されました！'
  end

  private

  def set_current_teacher
    @current_teacher = Teacher.find(session[:teacher_id]) if session[:teacher_id]
    unless @current_teacher
      flash[:alert] = '教師が見つかりません。ログインしてください。'
      redirect_to login_path and return
    end
  end

  def group_assignment_params
    params.require(:group_assignment).permit(:title, :group_count, :strategy, student_ids: [], ability_selection: [], skill_ids: [])
  end
end
