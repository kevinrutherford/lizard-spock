class LizardSpockBot

  def initialize(strategy, name, store)
    @strategy = strategy
  end

  def start(dynamite_count)
    @strategy.start(dynamite_count)
  end

  def move
    @strategy.move
  end

  def opponents_move(move)
    @strategy.opponents_move
  end

  def game_log
    @strategy.game_log
  end

end

