module ApplicationHelper
  def title(title_content)
    content_for(:title) { title_content }
  end
end
