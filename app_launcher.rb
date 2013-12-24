require 'sinatra/base'
require 'redis'
require_relative 'bots/lizard_spock_bot'
require_relative 'bots/random_bot'
require_relative 'bots/delayer'

class LizardSpock < Sinatra::Base

  configure :production, :development do
    enable :logging
  end

  post '/:bot_name/start' do
    bot(params[:bot_name]).start(params['dynamiteCount'].to_i)
  end

  get '/:bot_name/move' do
    bot(params[:bot_name]).move
  end

  post '/:bot_name/move' do
    bot(params[:bot_name]).opponents_move(params['lastOpponentMove'])
  end

  get '/:bot_name/log' do
    "#{bot(params[:bot_name]).game_log}"
  end

  get '/' do
    '<a href="/random/log">Random</a>'
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  def redis
    return @redis if @redis
    redisUri = ENV['REDISTOGO_URL'] || 'redis://localhost:6379'
    uri = URI.parse(redisUri)
    begin
      @redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
      @redis.keys
    rescue
      require_relative 'hash_store'
      @redis = HashStore.new
    end
    return @redis
  end

  def bot(name)
    LizardSpockBot.new(strategy(name), name, redis)
  end

  def strategy(name)
    if @strategies.nil?
      @strategies = {
        'random' => RandomBot.new(redis),
        'delayer' => Delayer.new(redis),
      }
    end
    @strategies[name]
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # start the server if ruby file executed directly
  run! if app_file == $0
end

