FROM ruby:3.0.5-buster

WORKDIR /usr/src/app

COPY ./Gemfile .

RUN gem install jekyll bundler

RUN bundle install
