DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/litmus_development.db")

require './models/subscriber'

DataMapper.finalize
Subscriber.auto_upgrade!