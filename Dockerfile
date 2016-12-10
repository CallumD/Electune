FROM ruby:latest

RUN mkdir -p /src && \
    mkdir -p /src/log /src/tmp && \
    touch /src/log/production.log
WORKDIR /src

# Optimisation: copy the Gemfiles and bundle install first to enable docker to use cached layers
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --deployment --without development:test

COPY . .

RUN bundle exec rake assets:precompile

RUN chmod -R g+rw /src
USER 1001

EXPOSE 8080

CMD ["entrypoint.sh", $APP_ROLE]
