module PlaylistHelper

  def render_upvote playlist_item, target
    link_to "upvote", upvote_path(playlist_item, target: target), method: :post, remote: true unless playlist_item.already_upvoted_by_user? session[:user_id]
  end

  def render_veto playlist_item, target
    link_to "veto", veto_path(playlist_item, target: target), method: :post, remote: true unless playlist_item.already_vetoed_by_user? session[:user_id]
  end
end
