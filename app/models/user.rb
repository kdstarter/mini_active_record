require './lib/active_record/base.rb'
# autoload(:ActiveRecord, './lib/active_record/base.rb')

class User < ActiveRecord::Base
  attr_accessor :name, :email

end
