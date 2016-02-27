FROM rails:4.2.5.1
MAINTAINER Dongri Jin

COPY ./hoge /var/app/hoge

WORKDIR /var/app/hoge

RUN bundle install
RUN bundle exec rake db:migrate

EXPOSE 3000

CMD rm -rf /var/app/hoge/tmp/pids/server.pid && bundle exec rails server --port 3000 --binding 0.0.0.0

# CMD ["bundle", "exec", "rails", "server", "--port", "3000", "--binding", "0.0.0.0"]
