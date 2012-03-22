require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/flash'
require 'rack/csrf'
require 'data_mapper'
require 'slim'


enable :sessions
use Rack::Csrf, :raise => true

set :public_folder, File.dirname(__FILE__) + '/../public'
set :views, File.dirname(__FILE__) + '/../views'
set :database_url, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/litmus_development.sqlite3"
set :name, ENV['ADMIN_USERNAME'] || 'admin'
set :password, ENV['ADMIN_PASSWORD'] || 'admin'

if settings.environment != :production && File.directory?('db') == false
  Dir.mkdir('db')
end

DataMapper.setup(:default, settings.database_url)

require './models/subscriber'
require './helpers/authorize'
require './helpers/csrf'

DataMapper.finalize
Subscriber.auto_upgrade!
