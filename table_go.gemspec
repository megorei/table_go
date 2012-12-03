# -*- encoding: utf-8 -*-
require File.expand_path('../lib/table_go/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Lars Gollnow', 'Vladimir Glusic']
  gem.email         = ['lg@megorei.com', 'exsemt@gmail.com']
  gem.description   = %q{simple, flexible and fast html table generator}
  gem.summary       = %q{}
  gem.homepage      = 'http://github.com/megorei/table_go/'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'table_go'
  gem.require_paths = ['lib']
  gem.version       = TableGo::VERSION

  gem.add_dependency 'actionpack'
  # gem.add_dependency 'minimal', :git => 'git://github.com/dinge/minimal.git'

  gem.add_development_dependency 'rspec'
end


