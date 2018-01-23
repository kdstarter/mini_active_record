require 'byebug'
require 'sinatra/base'
require 'sinatra/reloader'
require './app/models/user.rb'

class MyApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    user = User.new
    user.name = 'Tester1'
    "Hello, #{user.name}!"
  end

  run! if app_file == $0
end
