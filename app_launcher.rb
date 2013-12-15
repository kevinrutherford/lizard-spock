require 'sinatra/base'

class LizardSpock < Sinatra::Base

  configure :production, :development do
    enable :logging
  end

  post '/start' do
    logger.info "=== /start === #{params.inspect}"
    request.body.rewind
    body = request.body.read
    logger.info "=== /start === request.body = #{body.inspect}"
    logger.info "=== /start === request.form_data? = #{request.form_data?}"
  end

  get '/move' do
    'ROCK'
  end

  post '/move' do
    logger.info "=== /move === #{params.inspect}"
    request.body.rewind
    body = request.body.read
    logger.info "=== /move === request.body = #{body.inspect}"
    logger.info "=== /move === request.form_data? = #{request.form_data?}"
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end

