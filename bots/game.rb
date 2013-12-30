require_relative 'game_rules'

class Game

  def initialize(random = Random.new)
    @random = random
  end

  def start(params)
    @start_time = Time.now
    @opponent = params['opponentName']
    @oppo_dynamite = @dynamite_count = params['dynamiteCount'].to_i || 100
    @log = []
    record "New game vs #{@opponent}, "
    record "Dynamite count = #{@dynamite_count}"
    @draws = 0
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
    @draws += 1 if @my_last_move == @oppo_last_move
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

  private

  def generate_move
    case @opponent
    when 'Botulism'
      'SCISSORS'
    when 'Botswana'
      'PAPER'
    when 'FATBOTSLIM'
      # @oppo_last_move || random_move
      # GameRules.new.moves_that_beat(@oppo_last_move, @dynamite_count > 0)[0]
      # @dynamite_count > 0 ? 'DYNAMITE' : random_move
      return 'WATERBOMB' if ((@my_last_move == @oppo_last_move) && (@oppo_dynamite > 0))
      return 'DYNAMITE' if @dynamite_count > 0
      # GameRules.new.moves_that_lose_to(@my_last_move, @dynamite_count > 0)[0]
      random_move
    else
      random_move
    end
  end

  def record(str)
    cur = @log || []
    cur << str
    @log = cur
  end

end

