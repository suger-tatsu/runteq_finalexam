class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end
  
  def create
    @student = Student.new(student_params)
  
    if session[:teacher_id]
      @student.teacher_id = session[:teacher_id] # ここでteacher_idを設定
    else
      flash[:alert] = '教師が見つかりません。ログインしてください。'
      redirect_to login_path and return 
    end
  
    if @student.save
      redirect_to students_path, notice: '生徒が作成されました'
    else
      puts @student.errors.full_messages
      render :new
    end
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
      redirect_to students_path, notice: '生徒情報が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to students_path, notice: '生徒が削除されました。'
  end

  private
  
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
