curl -X POST -s 'http://localhost:9292/playlists/1/current.json' | grep song_link | sed -e 's/"song_link": \(.*\)/\1/' | sed -e 's/^[ \t]*//'
