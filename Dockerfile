FROM ruby:2.6.2

ENV LANG C.UTF-8

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get update -qq && apt-get install -y \
    build-essential \
    nodejs \
 && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

ENV APP_HOME /usr/src/app

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile /$APP_HOME/Gemfile
ADD Gemfile.lock /$APP_HOME/Gemfile.lock
RUN bundle install
COPY . /$APP_HOME

CMD ["rails", "s", "-b", "0.0.0.0"]