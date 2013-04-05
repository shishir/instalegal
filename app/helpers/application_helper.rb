module ApplicationHelper

  def full_title(page_title)
    base_title = "Instalegal"
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
end
