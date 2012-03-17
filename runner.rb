require './config'

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
  protected!
  @subscribers = Subscriber.all
  slim :admin
end