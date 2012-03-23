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
    if request.xhr?
      json result: 'success', message: "이메일이 등록되었습니다!"
    else
      flash[:notice] = "이메일이 등록되었습니다!"
      redirect to('/')
    end
  else
    if request.xhr?
      json result: 'error', message: @subscriber.errors.full_messages.first
    else
      slim :index
    end
  end
end

get '/admin' do
  protected!
  @subscribers = Subscriber.all
  slim :admin
end