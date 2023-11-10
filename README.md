# README

Starter Api RoR

# Components

* Ruby 3.2.2
* Rails 7.1.1
* Testing : Rspec, FactoryBot, Shoulda Matchers, VCR, Webmock

# Depedencies

* PostgreSQL

# 3rd Party component / API

* None as of now

# How to run this Project

* Install Ruby (using either rbenv, asdf or rvm)
* Install bundler `gem install bundler`
* Install gems `bundle install`
* Create database `rails db:create`
* Migrate it `rails db:migrate`
* Start server `rails s`

# How to run test

* Make sure you have the create database (`rails db:create`) and install all the gems (`bundle install`)
* Migrate test db `bundle exec rails db:migrate RAILS_ENV=test`
* Run all test cases `bundle exec rspec spec/`

# Notes on instaling Postgre

* On MacOS you need to intall `postgresql`, `libpq` using homebrew and run `gem install pg -- --with-pg-config=/usr/local/opt/libpq/bin/pg_config`