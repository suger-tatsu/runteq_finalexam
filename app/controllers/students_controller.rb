class StudentsController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_student, only: %i[show edit update destroy]

  def index
    permitted = params.permit(:q, :sort, :page)
    @students = StudentQuery.new(current_teacher.students, permitted).call
  end

  def autocomplete
    names = current_teacher.students
                            .where("name ILIKE ?", "%#{params[:q]}%")
                            .limit(10)
                            .pluck(:name)
    render json: names
  end

  def new
    @form = StudentForm.new(teacher: current_teacher)
  end

  def create
    @form = StudentForm.new(student_form_params, teacher: current_teacher)
    if @form.save
      redirect_to students_path, notice: "生徒が作成されました"
    else
      Rails.logger.debug "🔥 バリデーションエラー: #{@form.errors.full_messages}"
      render :new
    end
  end

  def show; end

  def edit
    @form = StudentForm.new(student: @student, teacher: current_teacher)
  end

  def update
    @form = StudentForm.new(student_form_params,
                            student: @student,
                            teacher: current_teacher)
    if @form.update
      redirect_to students_path, notice: "生徒情報が更新されました。"
    else
      render :edit
    end
  end

  def destroy
    @student.destroy
    redirect_to students_path, notice: "生徒が削除されました。"
  end

  private

  def set_student
    @student = current_teacher.students.find_by(id: params[:id])
    redirect_to students_path, alert: "生徒が見つかりません" unless @student
  end

  def student_form_params
    params.require(:student_form).permit(
      :name, :gender, :height, :weight,
      :athletic_ability, :leadership, :cooperation, :science, :humanities
    )
  end
end
