autoload(:ActiveRecord, './lib/active_record/base.rb')

class Post < ActiveRecord::Base
  establish_connection database: 'my_active_record.db'
  attr_accessor :title, :content

  validates :user_id, presence: true
  validates :title, presence: true
  # validates :content, presence: true

end
