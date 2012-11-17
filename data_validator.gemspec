# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "data_validator/version"

Gem::Specification.new do |s|
  s.name        = "data_validator"
  s.version     = DataValidator::VERSION
  s.authors     = ["Spring_MT"]
  s.email       = ["today.is.sky.blue.sky@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "data_validator"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
