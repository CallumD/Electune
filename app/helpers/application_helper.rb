module ApplicationHelper
  def title(title_content)
    content_for(:title) { title_content }
  end

  # Following method taken from the excellent http://ruby.railstutorial.org/chapters/sign-up#sec-a_gravatar_image
  def gravatar_for(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.email, class: 'gravatar')
  end

  def js_notifications
    js = ''
    flash.each do |name, msg|
      js += "notify.#{humane_type_for_flash(name)}('#{msg}');"
    end
    js
  end

  private
  def humane_type_for_flash(name)
    name.to_sym == :notice ? 'info' : 'error'
  end
end
