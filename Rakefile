require 'sinatra'
require './config/bootstrap'
require './models/subscriber'

desc "This task is called by the Heroku scheduler add-on"
namespace :email do
  task :subscribe do
      puts "Updateing feed..."
      Subscriber.subscribe
      puts "done."
  end
end