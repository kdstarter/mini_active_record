# mini_active_record
Coding a mini active_record base gem step by step

For dev run with:

```shell
bundle install
ruby db/seeds.rb
ruby my_app.rb # rackup -p 4567
```

View at: [http://localhost:4567](http://localhost:4567)

Build local gem:
```
gem build mini_active_record.gemspec && gem install ./mini_active_record-1.0.1.gem
```

Gem Usage Example:
```
gem 'mini_active_record', '~> 1.0.0'

class User < ActiveRecord::Base
  establish_connection MyApp.settings.database_config

  validates :name, presence: true
  validates :email, presence: true do |v| v.to_s.include?('@') end
end

user = User.find_or_create_by!(name: 'Tester', email: 'test@gmail.com')
user.email = 'test.com'
```