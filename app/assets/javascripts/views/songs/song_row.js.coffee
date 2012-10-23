class Electune.Views.SongRow extends Backbone.View

  tagName: 'tr'
  template: JST['songs/song_row']
  events: {
    'click a.upvote': -> @model.upvote()
    'click a.veto': -> @model.veto()
  }

  initialize: ->
    @model.on('change', @handleChange, @)

  handleChange: ->
    if @model.get('votes') > 0
      @render()
    else
      @remove()

  render: ->
    @$el.html(@template(@model.toJSON()))
    this
