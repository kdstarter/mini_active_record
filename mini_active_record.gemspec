Gem::Specification.new do |s|
  s.name        = 'mini_active_record'
  s.version     = '1.0.0'
  s.license     = 'MIT'
  s.date        = '2018-01-22'
  s.summary     = 'A active_record base gem'
  s.description = 'A mini active_record base gem'
  s.authors     = ['Teddy Jiang']
  s.email       = 'agilejzl@gmail.com'
  s.files       = ['lib/active_record.rb', 'lib/active_record/base.rb']
  s.homepage    = 'https://github.com/agilejzl/mini_active_record'
  s.add_runtime_dependency 'activesupport', '~> 5.0', '>= 5.0.0'
end
