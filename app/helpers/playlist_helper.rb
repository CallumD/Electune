module PlaylistHelper

  def render_upvote song, target
    link_to "upvote", upvote_path(song, target: target), method: :post, remote: true unless song.already_upvoted_by_user? session[:user_id]
  end

  def render_veto song, target
    link_to "veto", veto_path(song, target: target), method: :post, remote: true unless song.already_vetoed_by_user? session[:user_id]
  end
end
