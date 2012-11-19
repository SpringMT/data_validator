# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'data_validator/version'

Gem::Specification.new do |s|
  s.name        = 'data_validator'
  s.version     = DataValidator::VERSION
  s.authors     = ['Spring_MT']
  s.email       = ['today.is.sky.blue.sky@gmail.com']
  s.homepage    = 'https://github.com/SpringMT/data_validator'
  s.summary     = %q{DataValidator is validation anywhere}

  s.rubyforge_project = 'data_validator'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'active_support', '~> 3.0.0'
  s.add_dependency 'i18n', '~> 0.6.0'

  s.description = <<description
    DataValidator has almost active_recorde validation methods.
description

end
