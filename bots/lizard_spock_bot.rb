class LizardSpockBot

  def initialize(strategy, name, store)
    @strategy = strategy
    @name = name
    @store = store
  end

  def start(dynamite_count)
    @strategy.start(dynamite_count)
  end

  def move
    @strategy.move
  end

  def opponents_move(move)
    @strategy.opponents_move(move)
  end

  def game_log
    @store.get("#{@name}/moves")
  end

end

