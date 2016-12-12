FROM ruby:latest

RUN mkdir -p /src && \
    mkdir -p /src/log /src/tmp && \
    touch /src/log/production.log
WORKDIR /src

RUN apt-get update && apt-get install -y ezstream

# Optimisation: copy the Gemfiles and bundle install first to enable docker to use cached layers
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --deployment --without development:test

COPY . .

RUN bundle exec rake assets:precompile

RUN chmod -R g+rw /src
RUN chmod +x entrypoint.sh
RUN chmod 644 ezstream/ezstream.xml
RUN chmod 755 ezstream/get_ezstream_filename.sh
USER 1001

EXPOSE 8080
RUN export PATH=$PATH:/src/ezstream

CMD /src/entrypoint.sh $APP_ROLE
