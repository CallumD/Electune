curl -X POST -s 'http://localhost:9292/playlists/1/current.json' | jq -r '.song_link'
