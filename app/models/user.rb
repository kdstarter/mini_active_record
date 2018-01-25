class User < ActiveRecord::Base
  establish_connection database: MyApp.settings.database_name, adapter: :sqlite3
  attr_accessor :id, :name, :email

  validates :name, presence: true
  validates :email, presence: true do |v| v.to_s.include?('@') end

end
