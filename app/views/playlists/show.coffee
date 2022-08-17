$("#<%=@playlist.name%>_table tbody").replaceWith("<tbody><%= escape_javascript(render partial: 'playlist_item', collection: @playlist.playlist_items) %></tbody>");
