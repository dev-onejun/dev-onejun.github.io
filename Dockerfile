FROM ruby:3.0.5-slim-buster

WORKDIR /usr/src/app

COPY ./Gemfile .

RUN apt update && \
    apt install ruby-dev gcc g++ libffi-dev make -y

RUN gem install bundler && \
    gem install jekyll


RUN bundle install

CMD ["bundle", "exec", "jekyll", "serve", "-H0.0.0.0", "--port=4000"]
