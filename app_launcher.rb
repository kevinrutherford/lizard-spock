require 'sinatra/base'

class LizardSpock < Sinatra::Base

  configure :production, :development do
    enable :logging
  end

  post '/start' do
  end

  get '/move' do
    move = 'SCISSORS'
    logger.info "======= me: #{move}"
    move
  end

  post '/move' do
    logger.info "======= him: #{params['lastOpponentMove']} (#{params['round']}), "
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # start the server if ruby file executed directly
  run! if app_file == $0
end

