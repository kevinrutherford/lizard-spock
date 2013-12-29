class Game

  def initialize
    @random = Random.new
  end

  def start(params)
    @start_time = Time.now
    @opponent = params['opponentName']
    @dynamite_count = params['dynamiteCount'] || 100
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

  private

  def generate_move
    case @opponent
    when 'Botulism'
      'SCISSORS'
    when 'Botswana'
      'PAPER'
    else
      random_move
    end
  end

  def random_move
    moves = ['ROCK', 'PAPER', 'SCISSORS']
    moves << 'DYNAMITE' if @dynamite_count > 0
    moves[@random.rand(moves.length)]
  end

  def record(str)
    cur = @log || []
    cur << str
    @log = cur
  end

end

