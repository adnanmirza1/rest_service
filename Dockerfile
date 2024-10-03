FROM ruby:3.3.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /rest_service
COPY Gemfile /rest_service/Gemfile
COPY Gemfile.lock /rest_service/Gemfile.lock
COPY . .
RUN bundle install
CMD ["rails", "server", "-b", "0.0.0.0"]
