class SkillQuery
  def initialize(relation, params)
    @relation = relation
    @params = params
  end

  def call
    skills = @relation
    skills = skills.where("name ILIKE ?", "%#{@params[:q]}%") if @params[:q].present?

    case @params[:sort]
    when "name"
      skills = skills.order(:name)
    when "created_at_desc"
      skills = skills.order(created_at: :desc)
    when "created_at_asc"
      skills = skills.order(created_at: :asc)
    end

    skills.page(@params[:page]).per(12)
  end
end
