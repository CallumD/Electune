class Electune.Views.SongRow extends Backbone.View

  tagName: 'tr'
  template: JST['songs/song_row']
  events: {
    'click a.upvote': -> @model.upvote()
    'click a.veto': -> @model.veto()
  }

  initialize: ->
    @model.on('change', @render, @)

  render: ->
    @$el.html(@template(@model.toJSON()))
    this
