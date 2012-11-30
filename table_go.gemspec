Gem::Specification.new do |s|
  s.name        = 'table_go'
  s.version     = '0.0.5'
  s.date        = '2012-11-28'
  s.summary     = 'rock the table'
  s.description = 'ok'
  s.authors     = ['Lars Gollnow', 'Vladimir Glusic']
  s.email       = ['lg@megorei.com', 'exsemt@gmail.com']
  s.files       = Dir.glob("{lib}/**/*")
  s.test_files  = Dir.glob("{spec,test}/**/*.rb"
  s.homepage    = 'http://rubygems.org/gems/table_go'

  s.add_dependency 'actionpack'
  # s.add_dependency 'minimal', :git => 'git://github.com/dinge/minimal.git'

  s.add_development_dependency 'rspec'
end