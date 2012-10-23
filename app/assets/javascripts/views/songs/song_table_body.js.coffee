class Electune.Views.SongTableBody extends Backbone.View

  render: ->
    $el = @$el

    @collection.each (song) ->
      $el.append(new Electune.Views.SongRow({model: song}).render().el)

    this
