class RandomBot

  def initialize(store, random = Random.new)
    @store = store
    @random = random
  end

  def start(dynamite_count)
    @store.set('random/moves', '')
    @store.set('random/dynamite_left', dynamite_count)
  end

  def move
    my_move = legal_moves[@random.rand(legal_moves.length)]
    @store.set('random/my_last_move', my_move)
    if my_move == 'DYNAMITE'
      dyn = @store.get('random/dynamite_left').to_i - 1
      @store.set('random/dynamite_left', dyn)
    end
    history = @store.get('random/moves') || ''
    history = "#{history}[#{my_move}"
    @store.set('random/moves', history)
    my_move
  end

  def opponents_move(move)
    history = @store.get('random/moves') || ''
    history = "#{history},#{move}]\n"
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

