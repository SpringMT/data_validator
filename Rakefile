require "bundler/gem_tasks"

task :test do
  require 'rspec/core'
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:test) do |spec|
    #spec.rspec_opts = ["-c","-fs"]
    spec.pattern = FileList['spec/**/*_spec.rb']
  end
end

