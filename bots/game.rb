class Game

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
    'SCISSORS'
  end

  def record(str)
    cur = @log || []
    cur << str
    @log = cur
  end

end

