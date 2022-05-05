class Post < ActiveRecord::Base
  establish_connection MyApp.settings.database_config

  validates :user_id, presence: true
  validates :title, presence: true
  # validates :content, presence: true

end
