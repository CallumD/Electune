FROM ruby:latest

RUN mkdir src
WORKDIR src
COPY . .
RUN bundle install

EXPOSE 8080
CMD bundle exec passenger start
