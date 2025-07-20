class SkillsController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_skill, only: %i[edit update destroy]

  def index
    permitted = params.permit(:q, :sort, :page)
    @skills = SkillQuery.new(current_teacher.skills, permitted).call
  end

  def autocomplete
    names = current_teacher.skills
                           .where("name ILIKE ?", "%#{params[:q]}%")
                           .limit(10)
                           .pluck(:name)
    render json: names
  end

  def new
    @form = SkillForm.new(teacher: current_teacher)
  end

  def create
    @form = SkillForm.new(skill_form_params, teacher: current_teacher)
    if @form.save
      redirect_to skills_path, notice: "特技が作成されました！"
    else
      render :new
    end
  end

  def edit
    @form = SkillForm.new(skill: @skill, teacher: current_teacher)
  end

  def update
    @form = SkillForm.new(skill_form_params, skill: @skill, teacher: current_teacher)
    if @form.update
      redirect_to skills_path, notice: "特技が更新されました！"
    else
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
    redirect_to skills_path, alert: "特技が見つかりません" unless @skill
  end

  def skill_form_params
    params.require(:skill_form).permit(:name, student_ids: [])
  end
end
