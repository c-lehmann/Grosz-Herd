FROM ruby:2.3
LABEL author="Christian Lehmann <cl@c-lehmann.de>"

COPY generator /app
WORKDIR /app

RUN bundle install
ENTRYPOINT ["ruby", "run.rb"]
EXPOSE 4567