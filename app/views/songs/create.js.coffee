$("#new_song")[0].reset();
$("#<%= params[:target] %>").append("<%= escape_javascript(render partial: 'playlists/song', locals: {song: @song} ) %>");
