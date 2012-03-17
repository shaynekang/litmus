require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/flash'
require 'data_mapper'

require 'slim'

enable :sessions

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/litmus_development.db")

class Subscriber
  include DataMapper::Resource
  
  property :id, Serial, unique: true
  property :email, String, :required => true, :unique => true,
     :format   => :email_address,
     :messages => {
       :presence  => 'We need your email address.',
       :is_unique => 'We already have that email.',
       :format    => "Doesn't look like an email address to me ..."
     }
end

DataMapper.finalize
Subscriber.auto_upgrade!

get '/' do
  @subscriber = Subscriber.new
  slim :index
end

post '/subscribe' do
  @subscriber = Subscriber.new(params[:subscriber])
  if @subscriber.save
    flash[:notice] = "Thanks for Subscribe!"
    redirect to('/')
  else
    slim :index
  end
end

get '/admin' do
  @subscribers = Subscriber.all
  slim :admin
end