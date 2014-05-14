# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'table_go/version'

Gem::Specification.new do |gem|
  gem.authors       = ['Lars Gollnow', 'Vladimir Glusic']
  gem.email         = ['lg@megorei.com', 'exsemt@gmail.com']
  gem.description   = %q{simple, flexible and fast html table generator}
  gem.summary       = %q{}
  gem.homepage      = 'http://github.com/megorei/table_go/'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'table_go'
  gem.require_paths = ['lib']
  gem.version       = TableGo::VERSION

  gem.add_dependency 'actionpack'
  gem.add_dependency 'fastercsv' if RUBY_VERSION < '1.9'
  gem.add_dependency 'axlsx'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'haml'
end


