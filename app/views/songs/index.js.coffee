$("#search_form")[0].reset();
$("#results_table").empty();
$(".search_button").removeClass('disabled');
<% unless @songs.blank?  %>
$(".add_song_button").removeClass('disabled');
$("#results_table").append("<table class=\"table\" id='track_table'><tr><th>Name</th><th>Length</th><th>Link</th><th>Album Name</th></tr></table>");
$("#track_table").append("<%= escape_javascript(render partial: 'songs/track', collection: @songs ) %>");
<% end %>
