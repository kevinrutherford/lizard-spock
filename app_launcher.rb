require 'sinatra/base'

class LizardSpock < Sinatra::Base

  configure :production, :development do
    enable :logging
  end

  post '/start' do
    @@moves = ''
  end

  get '/move' do
    'SCISSORS'
  end

  post '/move' do
    @@moves += "#{params['lastOpponentMove']} (#{params['round']}), "
  end

  get '/' do
    @@moves
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # start the server if ruby file executed directly
  run! if app_file == $0
end

