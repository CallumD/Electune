$("#search_form")[0].reset();
$("#results_table").empty();
$(".search_button").removeClass('disabled');
<% unless @albums.blank?  %>
$(".add_song_button").removeClass('disabled');
$("#results_table").append("<%= escape_javascript(render partial: 'album_table') %>");
$("#song_table").append("<%= escape_javascript(render partial: 'album', collection: @albums) %>");
<% end %>
