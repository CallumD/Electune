FROM ruby:latest

RUN mkdir src
WORKDIR src

# Optimisation: copy the Gemfiles and bundle install first to enable docker to use cached layers
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

COPY . .
RUN bundle install --deployment --without development:test
RUN touch log/production.log
RUN chmod 666 log/production.log

EXPOSE 8080
CMD bundle exec rackup -p 8080
