FROM ruby:3.1.2

# Install Node.js and PostgreSQL client
RUN apt-get update -qq && \
    apt-get install -y nodejs postgresql-client

# Install Bundler
RUN gem install bundler:2.3.6

# Set environment variables
ENV BUNDLE_PATH=/usr/local/bundle
ENV RAILS_ENV=production

# Set the working directory to /app
WORKDIR /app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile* ./

# Install gems
RUN bundle install

# Copy the precompiled assets and the rest of the application code
COPY . .

# Expose the port that Rails will run on
EXPOSE 3000

# Start the Rails server in production mode
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
