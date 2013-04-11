# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activerecord_uuid_as_pk/version'

Gem::Specification.new do |gem|
  gem.name          = "activerecord_uuid_as_pk"
  gem.version       = ActiveRecordUUIDAsPK::VERSION
  gem.authors       = ["Shou Takenaka"]
  gem.email         = ["shou_takenaka@guihua.jp"]
  gem.description   = %q{activerecord_uuid_as_pk is a extension for ActiveRecord to enable to use uuid for id attribute.}
  gem.summary       = %q{ActiveRecord extension to use uuid for id attribute}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "uuidtools"
  gem.add_development_dependency "rails"
  gem.add_development_dependency "mysql2"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rspec-rails"
  gem.add_development_dependency "simplecov"
end
