require 'rubygems'
require 'bundler/setup'
require 'sinatra/flash'
require 'sinatra/contrib'
require 'rack/csrf'
require 'data_mapper'
require 'slim'
require 'pony'
require 'feedzirra'

enable :sessions
use Rack::Csrf, :raise => true

set :database_url, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/litmus_development.sqlite3"
set :name, ENV['ADMIN_USERNAME'] || 'admin'
set :password, ENV['ADMIN_PASSWORD'] || 'admin'

if settings.environment != :production and File.directory?('db') == false
  Dir.mkdir('db')
end

require './lib/emailable'

DataMapper.setup(:default, settings.database_url)

require './models/subscriber'

DataMapper.finalize
Subscriber.auto_upgrade!

require './helpers/authorize'
require './helpers/csrf'
