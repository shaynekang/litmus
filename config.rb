require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/flash'
require 'data_mapper'

enable :sessions

require 'slim'

require './config/data_mapper'