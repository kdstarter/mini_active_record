# require './lib/active_record/base.rb'
autoload(:ActiveRecord, './lib/active_record/base.rb')

class User < ActiveRecord::Base
  establish_connection database: 'my_active_record.db'
  attr_accessor :name, :email

  validates :name, presence: true
  validates :email, presence: true do |v| v.to_s.include?('@') end

end
