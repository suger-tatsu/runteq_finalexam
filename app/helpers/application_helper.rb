module ApplicationHelper
  def next_direction(column)
    if params[:sort] == column
      params[:direction] == "asc" ? "desc" : "asc"
    else
      "asc"
    end
  end
end
