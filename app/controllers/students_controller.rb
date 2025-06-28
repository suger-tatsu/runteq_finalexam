class StudentsController < ApplicationController
  before_action :require_teacher_login
  before_action :set_student, only: %i[show edit update destroy]

  def index
    @students = StudentQuery.new(current_teacher.students, params).call
  end

  def autocomplete
    names = current_teacher.students.where("name ILIKE ?", "%#{params[:q]}%").limit(10).pluck(:name)
    render json: names
  end

  def new
    @student = Student.new
  end

  def create
    @student = current_teacher.students.build(student_params)
    if @student.save
      redirect_to students_path, notice: "生徒が作成されました"
    else
      Rails.logger.debug "🔥 バリデーションエラー: #{@student.errors.full_messages}"
      render :new
    end
  end

  def show; end
  def edit; end

  def update
    if @student.update(student_params)
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

  def current_teacher
    @current_teacher ||= Teacher.find_by(id: session[:teacher_id])
  end

  def require_teacher_login
    unless current_teacher
      flash[:alert] = "ログインしてください"
      redirect_to login_path
    end
  end

  def set_student
    @student = current_teacher.students.find(params[:id])
  end

  def student_params
    params.require(:student).permit(
      :name, :gender, :height, :weight,
      :athletic_ability, :leadership, :cooperation, :science, :humanities
    ).tap do |whitelisted|
      whitelisted[:height] = whitelisted[:height].to_f
      whitelisted[:weight] = whitelisted[:weight].to_f
      %i[
        athletic_ability leadership cooperation
        science humanities
      ].each do |attr|
        whitelisted[attr] = whitelisted[attr].to_i
      end
    end
  end
end
