require_relative 'game_rules'

class Game

  def initialize(random = Random.new)
    @random = random
    @log = []
  end

  def start(params)
    @start_time = Time.now
    @opponent = params['opponentName']
    @dynamite_count = params['dynamiteCount'].to_i || 100
    @oppo_dynamite = @dynamite_count
    @last_was_draw = false
    record "New game vs #{@opponent}, "
    record "Dynamite count = #{@dynamite_count}"
  end

  def move
    move = generate_move
    @my_last_move = move
    @dynamite_count -= 1 if move == 'DYNAMITE'
    move
  end

  def oppo_move(move, round)
    @oppo_last_move = move
    @oppo_dynamite -= 1 if move == 'DYNAMITE'
    @oppo_draw_response = move if @last_was_draw
    extra = @my_last_move == @oppo_last_move ? ' ---------------- DRAW' : ''
    record "me: #{@my_last_move} him: #{move} (#{round})#{extra}"
  end

  def log
    @log
  end

  def start_time
    @start_time
  end

  def opponent
    @opponent
  end

  def random_move
    moves = ['ROCK', 'PAPER', 'SCISSORS']
    moves << 'DYNAMITE' if @dynamite_count > 0
    moves[@random.rand(moves.length)]
  end

  def random_standard_move
    moves = ['ROCK', 'PAPER', 'SCISSORS']
    moves[@random.rand(moves.length)]
  end

  def oppo_can_use_dynamite?
    @oppo_dynamite > 0
  end

  private

  def generate_move
    if @my_last_move == @oppo_last_move
      @last_was_draw = true
      return 'WATERBOMB' if @oppo_draw_response == 'DYNAMITE'
      return 'DYNAMITE' if @dynamite_count > 0
    else
      @last_was_draw = false
    end
    random_standard_move
  end

  def record(str)
    cur = @log || []
    cur << str
    @log = cur
  end

end





