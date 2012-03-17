require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/flash'
require 'data_mapper'
require 'slim'

enable :sessions

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/litmus_development.sqlite3")

require './models/subscriber'
require './helpers/authrize'

DataMapper.finalize
Subscriber.auto_upgrade!
