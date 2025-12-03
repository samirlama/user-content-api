FROM ruby:3.1.6

# Install essential Linux packages
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs curl && \
    rm -rf /var/lib/apt/lists/*

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

WORKDIR /app

# Cache gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy project files
COPY . .

# Precompile assets for production (optional)
# RUN bundle exec rails assets:precompile

CMD ["bash", "-c", "bundle exec rails s -b 0.0.0.0"]
