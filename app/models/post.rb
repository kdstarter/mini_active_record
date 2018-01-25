class Post < ActiveRecord::Base
  establish_connection database: MyApp.settings.database_name, adapter: :sqlite3
  attr_accessor :user_id, :title, :content

  validates :user_id, presence: true
  validates :title, presence: true
  # validates :content, presence: true

end
