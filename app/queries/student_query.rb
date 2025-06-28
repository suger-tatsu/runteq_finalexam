class StudentQuery
  SORT_OPTIONS = {
    "name_asc" => { name: :asc },
    "name_desc" => { name: :desc },
    "created_at_asc" => { created_at: :asc },
    "created_at_desc" => { created_at: :desc },
    "height_asc" => { height: :asc },
    "height_desc" => { height: :desc },
    "weight_asc" => { weight: :asc },
    "weight_desc" => { weight: :desc },
    "athletic_ability_asc" => { athletic_ability: :asc },
    "athletic_ability_desc" => { athletic_ability: :desc },
    "leadership_asc" => { leadership: :asc },
    "leadership_desc" => { leadership: :desc },
    "cooperation_asc" => { cooperation: :asc },
    "cooperation_desc" => { cooperation: :desc },
    "science_asc" => { science: :asc },
    "science_desc" => { science: :desc },
    "humanities_asc" => { humanities: :asc },
    "humanities_desc" => { humanities: :desc }
  }

  def initialize(scope, params)
    @scope = scope
    @params = params
  end

  def call
    result = search(@scope)
    result = sort(result)
    result.page(@params[:page]).per(10)
  end

  private

  def search(scope)
    return scope unless @params[:q].present?
    scope.where("name ILIKE ?", "%#{@params[:q]}%")
  end

  def sort(scope)
    sort_option = SORT_OPTIONS[@params[:sort]]
    sort_option ? scope.order(sort_option) : scope
  end
end
