require 'sinatra/base'
require 'redis'

class LizardSpock < Sinatra::Base

  configure :production, :development do
    enable :logging
  end

  post '/Start' do
    redis.set('started', Time.now.to_s)
  end

  get '/Move' do
    redis.set('started', Time.now.to_s)
    'ROCK'
  end

  post '/Move' do
    request.body.rewind
    body = request.body.read
    redis.set('last_move', Time.now.to_s)
    redis.set('last_body', body)
    redis.set('params', params.inspect)
  end

  get '/' do
    "#{redis.get('started')} -- #{redis.get('params')} -- #{redis.get('last_move')} -- #{redis.get('last_body')}"
  end

  def redis
    return @redis if @redis
    redisUri = ENV["REDISTOGO_URL"] || 'redis://redistogo:ed15feea87864017f037cf2fc1eec0d3@albacore.redistogo.com:9272/' || 'redis://localhost:6379'
    uri = URI.parse(redisUri)
    @redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end

