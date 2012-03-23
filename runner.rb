# encoding: UTF-8

require 'sinatra'
require './config/bootstrap'

get '/' do
  @subscriber = Subscriber.new
  slim :index
end

post '/subscribe' do
  @subscriber = Subscriber.new(params[:subscriber])
  if @subscriber.save
    flash[:notice] = "이메일이 등록되었습니다!"
    redirect to('/')
  else
    slim :index
  end
end

post '/subscribe.json' do
  @subscriber = Subscriber.new(params[:subscriber])
  if @subscriber.save
    json result: 'success', message: "이메일이 등록되었습니다!"
  else
    json result: 'error', message: @subscriber.error_message
  end
end

get '/admin' do
  protected!
  @subscribers = Subscriber.all
  slim :admin
end