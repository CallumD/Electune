$("#search_form")[0].reset();
$("#results_table").empty();
$(".search_button").removeClass('disabled');
<% unless @playlist_items.blank?  %>
$(".add_song_button").removeClass('disabled');
$("#results_table").append("<%= escape_javascript(render partial: 'song_table') %>");
$("#song_table").append("<%= escape_javascript(render partial: 'song', collection: @playlist_items) %>");
<% end %>
