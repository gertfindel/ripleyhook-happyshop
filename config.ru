require 'rubygems'
require 'bundler'
require 'open-uri'
Bundler.require
require './scrapper'
require './ripley-ws'
run Sinatra::Application
