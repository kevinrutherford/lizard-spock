require 'sinatra/base'
require 'redis'
require_relative 'bots/lizard_spock_bot'
require_relative 'bots/random_bot'
require_relative 'bots/delayer'

class LizardSpock < Sinatra::Base

  configure :production, :development do
    enable :logging
  end

  get '/:bot_name/start' do                         # TESTING ONLY!!!
    bot(params[:bot_name]).start('fred', 100)
  end

  post '/:bot_name/start' do
    bot(params[:bot_name]).start(params['opponentName'], params['dynamiteCount'].to_i)
  end

  get '/:bot_name/move' do
    bot(params[:bot_name]).move
  end

  post '/:bot_name/move' do
    bot(params[:bot_name]).opponents_move(params['lastOpponentMove'], params['round'])
  end

  get '/:bot_name/log' do
    name = params[:bot_name]
    "#{bot(name).game_log}"
  end

  get '/' do
    '<a href="/random/log">Random</a></br><a href="/delayer/log">Delayer</a>'
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  def persistent_store
    return @persistent_store if @persistent_store
    redisUri = ENV['REDISTOGO_URL'] || 'redis://localhost:6379'
    uri = URI.parse(redisUri)
    begin
      @persistent_store = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
      @persistent_store.keys
    rescue
      require_relative 'hash_store'
      @persistent_store = HashStore.new
    end
    return @persistent_store
  end

  def game(name, persistent_store)
    Game.new(name, persistent_store)
  end

  def bot(name)
    LizardSpockBot.new(strategy(name), game(name, persistent_store))
  end

  def strategy(name)
    if @strategies.nil?
      @strategies = {
        'random' => RandomBot,
        'delayer' => Delayer,
      }
    end
    @strategies[name].new
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # start the server if ruby file executed directly
  run! if app_file == $0
end

