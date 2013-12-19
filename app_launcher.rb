require 'sinatra/base'
require 'redis'
require_relative 'random_bot'

class LizardSpock < Sinatra::Base

  configure :production, :development do
    enable :logging
  end

  post %r{^/random/start$}i do
    RandomBot.new(redis).start
  end

  get %r{^/random/move$}i do
    RandomBot.new(redis).move
  end

  post %r{^/random/move$}i do
    RandomBot.new(redis).opponents_move(params["lastOpponentMove"])
  end

  get '/random' do
    "#{RandomBot.new(redis).game_log}"
  end

  get '/' do
    '<a href="/random">Random</a>'
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  def redis
    return @redis if @redis
    redisUri = ENV["REDISTOGO_URL"] || 'redis://localhost:6379'
    uri = URI.parse(redisUri)
    begin
      @redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
      @redis.keys
    rescue
      require_relative 'hash_store'
      @redis = HashStore.new
    end
  end

  def bots
    @bots ||= {}
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # start the server if ruby file executed directly
  run! if app_file == $0
end

