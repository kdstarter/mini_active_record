class User < ActiveRecord::Base
  establish_connection MyApp.settings.database_config

  validates :name, presence: true
  validates :email, presence: true do |v| v.to_s.include?('@') end

end
