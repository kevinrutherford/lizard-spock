require 'sinatra/base'
require 'redis'

class LizardSpock < Sinatra::Base

  configure :production, :development do
    enable :logging
  end

  post %r{^/random/start$}i do
    clear_history
  end

  get %r{^/random/move$}i do
    my_move = ['ROCK', 'PAPER', 'SCISSORS'][Random.new.rand(3)]
    log_my_move(my_move)
    my_move
  end

  post %r{^/random/move$}i do
    move = params["lastOpponentMove"]
    log_opponents_move(move)
  end

  get '/random' do
    "#{game_log}"
  end

  get '/' do
    '<a href="/random">Random</a>'
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  def redis
    return @redis if @redis
    redisUri = ENV["REDISTOGO_URL"] || 'redis://localhost:6379'
    uri = URI.parse(redisUri)
    @redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  def clear_history
    redis.set('random/moves', '')
  end

  def log_my_move(move)
    redis.set('random/my_last_move', move)
  end

  def log_opponents_move(move)
    history = redis.get('random/moves') || ''
    history = history + ',' + move
    redis.set('random/moves', history)
  end

  def game_log
    redis.get('random/moves')
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # start the server if ruby file executed directly
  run! if app_file == $0
end

