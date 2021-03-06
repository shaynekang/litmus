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
    json result: 'success', message: @subscriber.success_message
  else
    json result: 'error', message: @subscriber.error_message
  end
end

get '/admin' do
  need_authorize!
  @subscribers = Subscriber.all
  slim :admin
end

post '/admin/subscribers/:id/remove' do
  @subscriber = Subscriber.get(params[:id])
  @subscriber.destroy
  flash[:notice] = "이메일을 성공적으로 삭제했습니다."
  redirect to('/admin')
end
