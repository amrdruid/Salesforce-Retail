FROM ruby:2.7

RUN apt-get update -qq && apt-get install -y build-essential

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

RUN mkdir /salesforce-retail
WORKDIR /salesforce-retail
ADD Gemfile /salesforce-retail/Gemfile
ADD Gemfile.lock /salesforce-retail/Gemfile.lock
RUN bundle install
ADD . /salesforce-retail
