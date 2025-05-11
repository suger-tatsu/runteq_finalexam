class GroupAssignmentsController < ApplicationController
  before_action :set_current_teacher
  def index
    @group_assignments = GroupAssignment.all
  end

  def new
    @group_assignment = GroupAssignment.new
    @students = current_teacher.students
  end

  def create
    @group_assignment = GroupAssignment.new(group_assignment_params)
    @group_assignment.teacher_id = @current_teacher.id
    @students = current_teacher.students

    if @group_assignment.save
      create_groups_based_on_abilities(@group_assignment)
      redirect_to group_assignments_path, notice: "グループ分けを作成しました"
    else
      render :new
    end
  end

  def show
    @group_assignment = GroupAssignment.find(params[:id])
    @groups = @group_assignment.groups.includes(:students) # グループとその生徒も一緒に取得
  end

  def destroy
  @group_assignment = GroupAssignment.find(params[:id])

  @group_assignment.groups.each do |group|
    group.group_students.destroy_all
  end

  @group_assignment.groups.destroy_all

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

  def create_groups_based_on_abilities(group_assignment)
    return unless params[:group_assignment].present? && params[:group_assignment][:student_ids].present?

    student_ids = params[:group_assignment][:student_ids].map(&:to_i)
    students = Student.where(id: student_ids)

    # 生徒の能力をもとにグループ分けするロジック
    groups = {}

    students.each do |student|
      key = determine_group_key(student)

      groups[key] ||= []
      groups[key] << student
    end

  # グループを作成
    groups.each do |key, group_students|
      group = group_assignment.groups.create(name: "#{key}グループ")
      group.students << group_students
    end
  end

  def determine_group_key(student)
  # ここで生徒の能力に基づいてグループのキーを決定する
  # 例えば、能力の平均値や特定の条件を使って決定するナ
  # この例では `athletic_ability` を使うと仮定
    case student.athletic_ability
    when 0..3
      '低'
    when 4..7
      '中'
    else
      '高'
    end

    case student.leadership
    when 0..3
      '低'
    when 4..7
      '中'
    else
      '高'
    end

    case student.cooperation
    when 0..3
      '低'
    when 4..7
      '中'
    else
      '高'
    end

    case student.humanities
    when 0..3
      '低'
    when 4..7
      '中'
    else
      '高'
    end

    case student.science
    when 0..3
      '低'
    when 4..7
      '中'
    else
      '高'
    end
  end

  def group_assignment_params
    params.require(:group_assignment).permit(:title) # 必要なパラメータを指定
  end
end
