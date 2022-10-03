# syntax=docker/dockerfile:1
FROM ruby:3.1.1
RUN apt-get update -qq \
 && apt-get install -y nodejs postgresql-client npm \
 && rm -rf /var/lib/apt/lists/* \
 && npm install --global yarn
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem update bundler --no-document \
    && gem clean bundler \
    && bundle update --bundler \
    && bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]