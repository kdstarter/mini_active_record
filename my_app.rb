require 'byebug'
require 'sinatra/base'
require 'sinatra/reloader'
require './app/models/user.rb'

class MyApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    user = User.new(name: 'Tester', email: 'test@test.com')
    user.email = 'test.com'
    "Hello, #{user.name}! (#{user.email})"
  end

  run! if app_file == $0
end
