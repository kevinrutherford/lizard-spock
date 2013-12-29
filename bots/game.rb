class Game

  def start(params)
    @opponent = params[opponentName]
    @dynamite_count = params[dynamiteCount]
    @log = "New game vs #{@opponent}, "
  end

  def move
    move = generate_move
    record "me: #{move}, "
    move
  end

  def oppo_move(move, round)
    record "him: #{move} (#{round}), "
  end

  def log
    @log
  end

  private

  def generate_move
    'SCISSORS'
  end

  def record(str)
    cur = @log || ''
    cur += str
    @log = cur
  end

end

