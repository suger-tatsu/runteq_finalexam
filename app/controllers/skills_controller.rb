class SkillsController < ApplicationController
    before_action :set_current_teacher

  def index
    @teacher = current_teacher

    @skills = @teacher.skills
    @skills = @skills.where("name ILIKE ?", "%#{params[:q]}%") if params[:q].present?

    case params[:sort]
    when "name"
      @skills = @skills.order(:name)
    when "created_at_desc"
      @skills = @skills.order(created_at: :desc)
    when "created_at_asc"
      @skills = @skills.order(created_at: :asc)
    end

    @skills = @skills.page(params[:page])
  end

  def autocomplete
    names = current_teacher.skills.where("name ILIKE ?", "%#{params[:q]}%").limit(10).pluck(:name)
    render json: names
  end

  def new
    @skill = Skill.new # 新しい特技のインスタンスを作成
    @students = current_teacher.students
  end

  def create
    @skill = Skill.new(skill_params) # パラメータから新しい特技を作成
    @skill.teacher_id = @current_teacher.id
    #@students = current_teacher.students

    if @skill.save
      @skill.student_ids = params[:skill][:student_ids] if params[:skill][:student_ids].present?
      redirect_to skills_path, notice: '特技が作成されました！' # 作成成功時のリダイレクト
    else
      render :new # 作成失敗時は新規作成フォームを再表示
    end
  end

  def show
    @skill = Skill.find(params[:id]) # 特技の詳細を取得
  end

  def edit
    @skill = Skill.find(params[:id]) # 特技の編集用インスタンスを取得
    @students = current_teacher.students
  end

  def update
    @skill = Skill.find(params[:id]) # 特技を取得
    if @skill.update(skill_params)
      redirect_to skills_path, notice: '特技が更新されました！' # 更新成功時のリダイレクト
    else
      render :edit # 更新失敗時は編集フォームを再表示
    end
  end

  def destroy
    @skill = Skill.find(params[:id]) # 特技を取得
    @skill.destroy # 特技を削除
    redirect_to skills_path, notice: '特技が削除されました！' # 削除後のリダイレクト
  end

  private

  def set_current_teacher
    @current_teacher = Teacher.find(session[:teacher_id]) if session[:teacher_id]
    unless @current_teacher
      flash[:alert] = '教師が見つかりません。ログインしてください。'
      redirect_to login_path and return
    end
  end

  def skill_params
    params.require(:skill).permit(:name, :teacher_id,student_ids: []) # 許可するパラメータを指定
  end
end
