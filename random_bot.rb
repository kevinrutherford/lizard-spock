class RandomBot

  def initialize(store, random = Random.new)
    @store = store
    @random = random
  end

  def start
    @store.set('random/moves', '')
    @store.set('random/dynamite_left', 100)
  end

  def move
    my_move = legal_moves[@random.rand(legal_moves.length)]
    @store.set('random/my_last_move', my_move)
    if my_move == 'DYNAMITE'
      dyn = @store.get('random/dynamite_left').to_i - 1
      @store.set('random/dynamite_left', dyn)
    end
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

  def legal_moves
    result = ['ROCK', 'PAPER', 'SCISSORS']
    if @store.get('random/dynamite_left').to_i > 0
      result << 'DYNAMITE'
    end
    result
  end

end

