$("#<%= params[:target] %>").replaceWith("<%= escape_javascript(render partial: 'playlists/song', locals: {song: @song} ) %>");
