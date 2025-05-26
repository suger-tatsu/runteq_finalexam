class StudentsController < ApplicationController
  before_action :set_current_teacher

  def index
  @students = current_teacher.students

  # 検索
  if params[:q].present?
    @students = @students.where("name ILIKE ?", "%#{params[:q]}%")
  end

  # 並び替え
  case params[:sort]
  when "name_asc"
      @students = @students.order(name: :asc)
  when "name_desc"
      @students = @students.order(name: :desc)
  when "created_at_asc"
      @students = @students.order(created_at: :asc)
  when "created_at_desc"
      @students = @students.order(created_at: :desc)
  when "height_asc"
      @students = @students.order(height: :asc)
  when "height_desc"
      @students = @students.order(height: :desc)
  when "weight_asc"
      @students = @students.order(weight: :asc)
  when "weight_desc"
      @students = @students.order(weight: :desc)
  when "athletic_ability_asc"
      @students = @students.order(athletic_ability: :asc)
  when "athletic_ability_desc"
      @students = @students.order(athletic_ability: :desc)
  when "leadership_asc"
      @students = @students.order(leadership: :asc)
  when "leadership_desc"
      @students = @students.order(leadership: :desc)
  when "cooperation_asc"
      @students = @students.order(cooperation: :asc)
  when "cooperation_desc"
      @students = @students.order(cooperation: :desc)
  when "science_asc"
      @students = @students.order(science: :asc)
  when "science_desc"
      @students = @students.order(science: :desc)
  when "humanities_asc"
      @students = @students.order(humanities: :asc)
  when "humanities_desc"
      @students = @students.order(humanities: :desc)
  end

    # ページネーション
    @students = @students.page(params[:page]).per(10)
  end

  def autocomplete
    names = current_teacher.students.where("name ILIKE ?", "%#{params[:q]}%").limit(10).pluck(:name)
    render json: names
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    @student.teacher_id = @current_teacher.id

    if @student.save
      redirect_to students_path, notice: "生徒が作成されました"
    else
      puts @student.errors.full_messages
      render :new
    end
  rescue ActiveRecord::RecordNotUnique
    @student.errors.add(:name, "はすでに登録されています")
    flash.now[:alert] = @student.errors.full_messages.join(", ")
    render :new
  end

  def show
    @student = Student.find(params[:id])
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      redirect_to students_path, notice: "生徒情報が更新されました。"
    else
      render :edit
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to students_path, notice: "生徒が削除されました。"
  end

  private

  def set_current_teacher
    @current_teacher = Teacher.find(session[:teacher_id]) if session[:teacher_id]
    unless @current_teacher
      flash[:alert] = "教師が見つかりません。ログインしてください。"
      redirect_to login_path and return
    end
  end

  def student_params
    params.require(:student).permit(:name, :gender, :height, :weight, :athletic_ability, :leadership, :cooperation, :science, :humanities).tap do |whitelisted|
      whitelisted[:height] = whitelisted[:height].to_f
      whitelisted[:weight] = whitelisted[:weight].to_f
      whitelisted[:athletic_ability] = whitelisted[:athletic_ability].to_i
      whitelisted[:leadership] = whitelisted[:leadership].to_i
      whitelisted[:cooperation] = whitelisted[:cooperation].to_i
      whitelisted[:science] = whitelisted[:science].to_i
      whitelisted[:humanities] = whitelisted[:humanities].to_i
    end
  end
end
