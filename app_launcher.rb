require 'sinatra/base'


configure do
  require 'redis'
  redisUri = ENV["REDISTOGO_URL"] || 'redis://localhost:6379'
  uri = URI.parse(redisUri)
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

class LizardSpock < Sinatra::Base

  configure :production, :development do
    enable :logging
  end

  post '/start' do
    puts "=== /start === #{params.inspect}"
    request.body.rewind
    body = request.body.read
    puts "=== /start === request.body = #{body.inspect}"
    puts "=== /start === request.form_data? = #{request.form_data?}"
  end

  get '/move' do
    'ROCK'
  end

  post '/move' do
    puts "=== /move === #{params.inspect}"
    request.body.rewind
    body = request.body.read
    puts "=== /move === request.body = #{body.inspect}"
    puts "=== /move === request.form_data? = #{request.form_data?}"
    REDIS.set('last_body', body)
  end

  get '/' do
    REDIS.get('last_body')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end

