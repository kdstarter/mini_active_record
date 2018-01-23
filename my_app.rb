require 'byebug'
require 'sinatra/base'
require 'sinatra/reloader'
# require './app/models/user.rb'
autoload(:User, './app/models/user.rb')
autoload(:Post, './app/models/post.rb')

class MyApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    user = User.new(name: 'Tester', email: 'test@test.com')
    user.email = 'test.com'
    post = Post.new(title: 'News')
    "Hello, #{user.name}! (#{user.email}), #{user.attribute_names}, #{post.attribute_names}"
  end

  run! if app_file == $0
end
