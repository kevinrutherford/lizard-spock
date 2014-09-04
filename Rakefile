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
  sh "curl -d 'opponentName=FATBOTSLIM\ndynamiteCount=100' http://localhost:5000/start"
end

task :move do
  sh "curl -d lastOpponentMove=ROCK http://localhost:5000/move"
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

task :forbes do
  sh 'echo >> Gemfile'
  sh 'git commit -a -m "Pointless test commit"'
  sh 'git push origin master'
end
