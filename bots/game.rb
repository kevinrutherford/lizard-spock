require_relative 'game_rules'

class Game

  def initialize(random = Random.new)
    @random = random
  end

  def start(params)
    @start_time = Time.now
    @opponent = params['opponentName']
    @dynamite_count = params['dynamiteCount'].to_i || 100
    @oppo_dynamite = @dynamite_count
    @log = []
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
    record "me: #{@my_last_move} him: #{move} (#{round}), "
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

  def oppo_can_use_dynamite?
    @oppo_dynamite > 0
  end

  private

  def generate_move
    case @opponent
    when 'Botulism'
      'SCISSORS'
    when 'Botswana'
      'PAPER'
    when 'FATBOTSLIM'
      fatbotslim
    else
      random_move
    end
  end

  def fatbotslim
    if @my_last_move == @oppo_last_move
      record "Draw: my dynamite = #{@dynamite_count}, his dynamite = #{@oppo_dynamite}"
      return 'WATERBOMB' if oppo_can_use_dynamite?
      return 'DYNAMITE' if @dynamite_count > 0
    end
    random_move
  end

  def record(str)
    cur = @log || []
    cur << str
    @log = cur
  end

end

