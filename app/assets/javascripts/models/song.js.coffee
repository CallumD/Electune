class Electune.Models.Song extends Backbone.Model

  url: ->
    return '/playlists/' + @get('playlist_id') + '/songs/' + @id

  upvote: ->
    @set('votes', @get('votes') + 1)
    @save()

  veto: ->
    @set('votes', @get('votes') - 1)
    @save()
