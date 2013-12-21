class RandomBot

  def initialize(store)
    @store = store
  end

  def start
    @store.set('random/moves', '')
  end

  def move
    my_move = ['ROCK', 'PAPER', 'SCISSORS'][Random.new.rand(3)]
    @store.set('random/my_last_move', my_move)
    my_move
  end

  def opponents_move(move)
    history = @store.get('random/moves') || ''
    history = history + ',' + move
    @store.set('random/moves', history)
  end

  def game_log
    @store.get('random/moves')
  end

end

