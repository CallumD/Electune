<% if @song.votes != 0 %>
	$("#<%= params[:target] %>").replaceWith("<%= escape_javascript(render partial: 'playlists/song', locals: {song: @song} ) %>");
<% else %>
	$("#<%= params[:target] %>").remove();
<% end %>

