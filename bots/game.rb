class Game

  def start(name)
    @log = "New game vs #{name}, "
  end

  def move
    move = 'SCISSORS'
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

  def record(str)
    cur = @log || ''
    cur += str
    @log = cur
  end

end

