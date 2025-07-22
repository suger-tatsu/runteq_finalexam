class GroupAssignmentQuery
  def initialize(relation, params)
    @relation = relation
    @params = params
  end

  def call
    result = @relation
    result = result.where("title ILIKE ?", "%#{@params[:q]}%") if @params[:q].present?

    case @params[:sort]
    when "title"
      result = result.order(:title)
    when "created_at_desc"
      result = result.order(created_at: :desc)
    when "created_at_asc"
      result = result.order(created_at: :asc)
    end

    result.page(@params[:page]).per(12)
  end
end
