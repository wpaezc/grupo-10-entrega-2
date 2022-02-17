FROM ruby:2.7.5
RUN apt-get update && apt-get install -y --no-install-recommends postgresql-client
COPY . .
RUN bundle install
CMD ["puma", "config.ru", "-C", "config/puma.rb"]
