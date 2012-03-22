# encoding: UTF-8

require 'sinatra'
require './config/bootstrap'

get '/' do
  @subscribers = Subscriber.all
  @subscriber = Subscriber.new
  slim :index
end

post '/subscribe' do
  @subscriber = Subscriber.new(params[:subscriber])
  if @subscriber.save
    flash[:notice] = "이메일이 등록되었습니다!"
    redirect to('/')
  else
    @subscribers = Subscriber.all
    slim :index
  end
end

get '/admin' do
  protected!
  @subscribers = Subscriber.all
  slim :admin
end