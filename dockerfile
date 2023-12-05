FROM ruby:3.1.2
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt-get install -y nodejs mysql-client
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp