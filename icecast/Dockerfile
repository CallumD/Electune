From ubuntu:16.04
MAINTAINER Callum Dryden <callumdryden@gmail.com>

RUN apt-get update \
 && DEBCONF_FRONTEND=noninteractive apt-get install -y icecast2

EXPOSE 8000

COPY icecast.xml /config/icecast.xml
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

USER icecast2

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/icecast2", "-c", "/config/icecast.xml"]
