class GroupAssignmentsController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_group_assignment, only: [ :show, :edit_groups, :update_groups, :destroy, :share_settings, :update_sharing, :toggle_sharing ]

  def index
    permitted = params.permit(:q, :sort, :page)
    @group_assignments = GroupAssignmentQuery.new(current_teacher.group_assignments, permitted).call
  end

  def autocomplete
    titles = current_teacher.group_assignments.where("title ILIKE ?", "%#{params[:q]}%").limit(10).pluck(:title)
    render json: titles
  end

  def new
    @group_assignment = GroupAssignment.new
    @students = current_teacher.students
    @skills = current_teacher.skills
  end

  def create
    @group_assignment = GroupAssignment.new_from_params(group_assignment_params, current_teacher)

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
    @groups = @group_assignment.groups.includes(:students)
  end

  def destroy
    @group_assignment.destroy
    redirect_to group_assignments_path, notice: "削除されました！"
  end

  def edit_groups
    @groups = @group_assignment.groups.includes(:students)
  end

  def update_groups
    @group_assignment.update_group_membership!(params[:groups] || {})
    redirect_to group_assignment_path(@group_assignment), notice: "グループ構成を更新しました"
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("グループ更新エラー: #{e.message}")
    flash[:alert] = "更新に失敗しました"
    redirect_to edit_groups_group_assignment_path(@group_assignment)
  end

  def share_settings; end

  def update_sharing
    @group_assignment.generate_public_token if @group_assignment.public_token.blank?

    if params[:group_assignment][:public_password].present?
      @group_assignment.public_password = params[:group_assignment][:public_password]
    end

    if @group_assignment.save
      redirect_to group_assignment_path(@group_assignment), notice: "共有設定を更新しました"
    else
      flash.now[:alert] = "保存に失敗しました"
      render :share_settings, status: :unprocessable_entity
    end
  end

  def toggle_sharing
    @group_assignment.update(public_enabled: !@group_assignment.public_enabled)
    redirect_to group_assignments_path, notice: "共有状態を変更しました"
  end

  private

  def set_group_assignment
    @group_assignment = current_teacher.group_assignments.find_by(id: params[:id])
    redirect_to group_assignments_path, alert: "グループ分けが見つかりません" unless @group_assignment
  end

  def group_assignment_params
    params.require(:group_assignment).permit(
      :title, :group_count, :strategy,
      :public_enabled, :public_password,
      student_ids: [],
      ability_selection: [],
      skill_ids: [],
      ability_weights: {}
    )
  end
end
