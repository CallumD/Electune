class Electune.Views.SongRow extends Backbone.View

  template: JST['songs/song_row']

  events: {
    'click a.upvote': -> @model.upvote()
    'click a.veto': -> @model.veto()
  }

  tagName: 'tr'
  render: ->

    @el.appendChild(@make('td', {}, @model.get('name')))
    @el.appendChild(@make('td', {}, @model.get('votes')))
    @el.appendChild(@make('td', {}, @make('a', {'class': 'upvote', href: 'javascript:void(0)'}, 'Upvote')))
    @el.appendChild(@make('td', {}, @make('a', {'class': 'veto', href: 'javascript:void(0)'}, 'Veto')))

    this
