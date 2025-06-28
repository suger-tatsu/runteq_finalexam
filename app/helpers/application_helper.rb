module ApplicationHelper
  def next_direction(column)
    if params[:sort] == column
      params[:direction] == "asc" ? "desc" : "asc"
    else
      "asc"
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    current_sort = params[:sort]
    direction = current_sort == "#{column}_asc" ? "desc" : "asc"

    icon = case current_sort
    when "#{column}_asc" then "▲"
    when "#{column}_desc" then "▼"
    else "⇅"  # ソート未選択時も分かりやすく
    end

    link_to "#{title} #{icon}".html_safe,
            request.query_parameters.merge(sort: "#{column}_#{direction}", page: nil),
            class: "text-blue-600 hover:underline whitespace-nowrap"
  end
end
