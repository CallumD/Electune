module ApplicationHelper
  def title(title_content)
    content_for(:title) { title_content }
  end

  def seconds_to_mins seconds
    mm, ss = seconds.divmod(60)
    "#{mm.round}:#{'%02d' % ss.round}"
  end
end
