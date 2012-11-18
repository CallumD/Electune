$("#search_form")[0].reset();
$("#results_table").empty();
$(".search_button").removeClass('disabled');
<% unless @songs.blank?  %>
$(".add_song_button").removeClass('disabled');
$("#results_table").append(<%= @songs.size %>);
<% end %>
