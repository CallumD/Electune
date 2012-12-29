$("#search_form")[0].reset();
$("#results_table").empty();
$(".search_button").removeClass('disabled');
<% unless @artists.blank?  %>
$(".add_song_button").removeClass('disabled');
$("#results_table").append("<%= escape_javascript(render partial: 'artist_table') %>");
$("#song_table").append("<%= escape_javascript(render partial: 'artist', collection: @artists) %>");
<% end %>
$(".loadonclick").click ->
    $(".loading").show();
$(".loading").hide();
