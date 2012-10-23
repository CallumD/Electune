class Electune.Models.Song extends Backbone.Model

  url: ->
    url = '/playlists/' + @get('playlist_id') + '/songs'
    url += '/' + @id if @id
    url

  upvote: ->
    @set('votes', @get('votes') + 1)
    @save()

  veto: ->
    @set('votes', @get('votes') - 1)
    @save()
