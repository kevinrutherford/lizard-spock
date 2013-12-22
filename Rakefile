Bundler.require
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

desc 'Push to github'
task :push => [:spec] do
  sh 'git push'
end

desc 'Deploy to Heroku'
task :deploy => [:spec, :push] do
  sh 'git push heroku master'
end

