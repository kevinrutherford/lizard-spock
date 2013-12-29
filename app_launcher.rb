require 'sinatra/base'
require_relative 'bots/game'

class LizardSpock < Sinatra::Base

  configure :production, :development do
    enable :logging
    set :game, Game.new
  end

  post '/start' do
    settings.game.start(params)
  end

  get '/move' do
    settings.game.move
  end

  post '/move' do
    settings.game.oppo_move(params['lastOpponentMove'], params['round'])
  end

  get '/' do
    haml :index, locals: {
      game: settings.game
    }
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # start the server if ruby file executed directly
  run! if app_file == $0
end

