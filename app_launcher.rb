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
    'ROCK'
  end

  post '/Move' do
    move = params["lastOpponentMove"]
    moves = redis.get('moves') || ''
    moves = moves + ',' + move
    redis.set('moves', moves)
  end

  get '/' do
    "#{redis.get('started')} -- #{redis.get('moves')}"
  end

  def redis
    return @redis if @redis
    redisUri = ENV["REDISTOGO_URL"] || 'redis://localhost:6379'
    uri = URI.parse(redisUri)
    @redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end

