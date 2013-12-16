require 'sinatra/base'

class LizardSpock < Sinatra::Base

  configure :production, :development do
    enable :logging
  end

  post '/start' do
    puts "=== /start === #{params.inspect}"
    request.body.rewind
    body = request.body.read
    puts "=== /start === request.body = #{body.inspect}"
    puts "=== /start === request.form_data? = #{request.form_data?}"
  end

  get '/move' do
    'ROCK'
  end

  post '/move' do
    puts "=== /move === #{params.inspect}"
    request.body.rewind
    body = request.body.read
    puts "=== /move === request.body = #{body.inspect}"
    puts "=== /move === request.form_data? = #{request.form_data?}"
  end

  get '/' do
    puts 'Hello'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end

