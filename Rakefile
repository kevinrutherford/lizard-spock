Bundler.require

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  task :default => :spec

  Dir['spec/**/*_spec.rb'].each do |s|
    task s do
      sh "bundle exec rspec #{s}"
    end
    task :allspec => [s]
  end

rescue LoadError
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

task :start do
  sh "curl -d opponentName=fred http://localhost:5000/start"
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

desc 'Push to github'
task :push => [:spec, :allspec] do
  sh 'git push'
end

desc 'Deploy to Heroku'
task :deploy => [:spec, :allspec, :push] do
  sh 'git push heroku master'
end

