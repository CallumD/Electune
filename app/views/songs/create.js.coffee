$("#addSongModal").modal('hide');
$("#<%= params[:target] %>").append("<%= escape_javascript(render partial: 'playlists/song', locals: {song: @song} ) %>");
