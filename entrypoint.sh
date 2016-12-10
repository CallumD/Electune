#!/bin/sh

if [ -n "$ICECAST_SOURCE_PASSWORD" ]; then
    sed -i "s/<sourcepassword>[^<]*<\/sourcepassword>/<sourcepassword>$ICECAST_SOURCE_PASSWORD<\/sourcepassword>/g" /src/ezstream/ezsteam.xml
fi
if [ -n "$ICECAST_URL" ]; then
    sed -i "s/<url>[^<]*<\/url>/<url>$ICECAST_RELAY_PASSWORD<\/url>/g" /src/ezstream/ezsteam.xml
fi
if [ -n "$ELECTUNE_URL" ]; then
    sed -i "s/http:\/\/localhost:9292/$ELECTUNE_URL/g" /src/ezstream/get_ezstream_filename.sh
fi

case $1 in
  worker)
    exec "bundle exec rake auto_shift:run"
    ;;
  *)
    exec "bundle exec rackup -p 8080"
    ;;
esac
