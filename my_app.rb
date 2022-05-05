require 'byebug'
require 'sinatra/base'
require 'sinatra/reloader'

# require 'active_record'
autoload(:ActiveRecord, './lib/active_record/base.rb')
autoload(:User, './app/models/user.rb')
autoload(:Post, './app/models/post.rb')

class MyApp < Sinatra::Base
  configure :development do
    set :database_config, { database: 'mini_active_record.db', adapter: :sqlite3 }
    register Sinatra::Reloader
  end

  get '/' do
    user = User.find_or_create_by!(name: 'Tester', email: 'test@gmail.com')
    user.email = 'test.com'
    post = Post.new(title: 'News')
    "Hello, #{user.name}! (#{user.email})
      <br/>Create a user: #{User.first.attributes},
      <br/>New a post: #{Post.first.attributes}"
  end

  run! if app_file == $0
end
