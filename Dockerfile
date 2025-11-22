FROM ruby:3.2-alpine

WORKDIR /app

RUN apk update && \
    apk add --no-cache \
      build-base \
      ruby-dev \
      yaml \
      yaml-dev \
      git

COPY . .
RUN bundle install

RUN apk del build-base ruby-dev && \
    rm -rf /var/cache/apk/*

CMD ["ruby", "bin/schedule"]
