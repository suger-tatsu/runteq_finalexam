class GroupAssignmentsController < ApplicationController
  before_action :set_current_teacher

  def index
    @group_assignments = current_teacher.group_assignments
    @group_assignments = @group_assignments.where("title ILIKE ?", "%#{params[:q]}%") if params[:q].present?

    case params[:sort]
    when "title"
      @group_assignments = @group_assignments.order(:title)
    when "created_at_desc"
      @group_assignments = @group_assignments.order(created_at: :desc)
    when "created_at_asc"
      @group_assignments = @group_assignments.order(created_at: :asc)
    end

    @group_assignments = @group_assignments.page(params[:page])
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
      flash.now[:alert] = @group_assignment.errors.full_messages.join(", ")
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
    redirect_to group_assignments_path, notice: "削除されました！"
  end

  def edit_groups
    @group_assignment = GroupAssignment.find(params[:id])
    @groups = @group_assignment.groups.includes(:students)
  end

  def update_groups
    @group_assignment = GroupAssignment.find(params[:id])

    ActiveRecord::Base.transaction do
      # 既存の割り当てを削除（安全策）
      GroupAssignmentStudent.where(group_assignment_id: @group_assignment.id).delete_all

      params[:groups]&.each do |group_id, student_ids|
        group = @group_assignment.groups.find(group_id)
        clean_ids = student_ids.reject(&:blank?).map(&:to_i)

        clean_ids.each do |student_id|
          GroupAssignmentStudent.create!(
            group_assignment: @group_assignment,
            group: group,
            student_id: student_id
          )
        end
      end
    end

    redirect_to group_assignment_path(@group_assignment), notice: "グループ構成を更新しました"
  end

  private

  def set_current_teacher
    @current_teacher = Teacher.find(session[:teacher_id]) if session[:teacher_id]
    unless @current_teacher
      flash[:alert] = "教師が見つかりません。ログインしてください。"
      redirect_to login_path and return
    end
  end

  def group_assignment_params
    params.require(:group_assignment).permit(
      :title, :group_count, :strategy,
      student_ids: [],
      ability_selection: [],
      skill_ids: [],
      ability_weights: {} # ← 追加
    )
  end
end
