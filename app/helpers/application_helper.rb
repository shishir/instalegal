module ApplicationHelper

  def full_title(page_title)
    base_title = "InstaLegal"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def navbar_item(text, path)
    opts = {}
    opts[:class] = 'active' if current_page?(path)
    content_tag(:li, opts) do
      link_to(text, path)
    end
  end

  def redirect_path_on_home_logo(user)
    if user.type == "Client"
      lawyers_path
    else
      lawyer_path(user)
    end
  end

end
