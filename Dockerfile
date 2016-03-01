FROM ruby
MAINTAINER Christian Lehmann <cl@c-lehmann.de>

RUN apt-get install -y git 
RUN git clone https://github.com/c-lehmann/Grosz-Herd.git

WORKDIR /Grosz-Herd/
RUN rm -rf .git archive
WORKDIR generator/
RUN bundle install
ENTRYPOINT ["ruby", "run.rb"]
EXPOSE 4567
