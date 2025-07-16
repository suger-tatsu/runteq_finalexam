class SkillsController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_skill, only: [ :show, :edit, :update, :destroy ]

  def index
    @skills = current_teacher.skills
    @skills = @skills.where("name ILIKE ?", "%#{params[:q]}%") if params[:q].present?

    case params[:sort]
    when "name"
      @skills = @skills.order(:name)
    when "created_at_desc"
      @skills = @skills.order(created_at: :desc)
    when "created_at_asc"
      @skills = @skills.order(created_at: :asc)
    end

    @skills = @skills.page(params[:page]).per(12)
  end

  def autocomplete
    names = current_teacher.skills.where("name ILIKE ?", "%#{params[:q]}%").limit(10).pluck(:name)
    render json: names
  end

  def new
    @skill = Skill.new
    @students = current_teacher.students
  end

  def create
    @skill = current_teacher.skills.build(skill_params)
    if @skill.save
      @skill.student_ids = params[:skill][:student_ids] if params[:skill][:student_ids].present?
      redirect_to skills_path, notice: "特技が作成されました！"
    else
      @students = current_teacher.students
      render :new
    end
  end

  def show
  end

  def edit
    @students = current_teacher.students
  end

  def update
    if @skill.update(skill_params)
      redirect_to skills_path, notice: "特技が更新されました！"
    else
      @students = current_teacher.students
      render :edit
    end
  end

  def destroy
    @skill.destroy
    redirect_to skills_path, notice: "特技が削除されました！"
  end

  private

  def set_skill
    @skill = current_teacher.skills.find_by(id: params[:id])
    unless @skill
      redirect_to skills_path, alert: "特技が見つかりません"
    end
  end

  def skill_params
    params.require(:skill).permit(:name, student_ids: [])
  end
end
