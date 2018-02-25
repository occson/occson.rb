FROM ruby:2.5.0

RUN mkdir -p /fake_occson
WORKDIR /fake_occson
COPY config.ru config.ru
EXPOSE 9292
RUN gem install rack
CMD ["rackup", "config.ru", "-o", "0.0.0.0", "-p", "9292"]
