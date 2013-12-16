require 'sinatra/base'

class LizardSpock < Sinatra::Base

  configure :production, :development do
    enable :logging

    require 'redis'
    redisUri = ENV["REDISTOGO_URL"] || 'redis://localhost:6379'
    uri = URI.parse(redisUri)
    REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  end

  post '/start' do
    REDIS.set('started', Time.now.to_s)
  end

  get '/move' do
    'ROCK'
  end

  post '/move' do
    request.body.rewind
    body = request.body.read
    REDIS.set('last_body', body)
  end

  get '/' do
    "#{REDIS.get('started')} -- #{REDIS.get('last_body')}"
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end

