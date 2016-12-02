FROM ruby:latest

RUN mkdir src
WORKDIR src
COPY . .
RUN bundle install --deployment --without development:test
RUN touch log/production.log
RUN chmod 666 log/production.log

EXPOSE 8080
CMD bundle exec rackup -p 8080
