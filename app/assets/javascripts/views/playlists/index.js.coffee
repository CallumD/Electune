class Electune.Views.PlaylistsIndex extends Backbone.View

  template: JST['playlists/index']

  render: ->

    $el = @$el

    @collection.each (song) ->
      row = new Electune.Views.SongRow({model: song})
      row.render();
      $el.append(row.el)

    this
