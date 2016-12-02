FROM ruby:latest

RUN mkdir src
WORKDIR src
COPY . .
RUN bundle install --deployment --without development:test

EXPOSE 8080
CMD bundle exec rackup -p 8080
