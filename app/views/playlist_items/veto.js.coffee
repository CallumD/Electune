<% if @playlist_item.votes != 0 %>
	$("#<%= params[:target] %>").replaceWith("<%= escape_javascript(render partial: 'playlists/playlist_item', locals: {playlist_item: @playlist_item} ) %>");
<% else %>
	$("#<%= params[:target] %>").remove();
<% end %>
