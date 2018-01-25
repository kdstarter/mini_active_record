require 'byebug'
require 'sinatra/base'
require 'sinatra/reloader'

# require 'active_record'
autoload(:ActiveRecord, './lib/active_record/base.rb')
autoload(:User, './app/models/user.rb')
autoload(:Post, './app/models/post.rb')

class MyApp < Sinatra::Base
  configure :development do
    set :database_name, 'mini_active_record.db'
    register Sinatra::Reloader
  end

  get '/' do
    user = User.new(name: 'Tester', email: 'test@test.com')
    user.email = 'test.com'
    post = Post.new(title: 'News')
    "Hello, #{user.name}! (#{user.email})
      <br/> #{User.all.first.attributes},
      <br/> #{Post.all.first.attributes}"
  end

  run! if app_file == $0
end
