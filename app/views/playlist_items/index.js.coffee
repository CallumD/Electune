$("#search_form")[0].reset();
$("#results_table").empty();
$(".search_button").removeClass('disabled');
<% unless @playlist_items.blank?  %>
$(".add_song_button").removeClass('disabled');
$("#results_table").append("<%= escape_javascript(render partial: 'track_table') %>");
$("#track_table").append("<%= escape_javascript(render partial: 'track', collection: @playlist_items) %>");
<% end %>
