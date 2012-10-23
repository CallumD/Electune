class Electune.Views.SongTableBody extends Backbone.View

  initialize: ->
    _.bindAll(this, 'addSong')
    @collection.on('add', @addSong)

  render: ->
    @collection.each @addSong
    this

  addSong: (song) ->
    if (song.get('votes') >= 0)
      @$el.append(new Electune.Views.SongRow({model: song}).render().el)
