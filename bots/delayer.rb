class Delayer

  def initialize(store, random = Random.new)
    @store = store
    @random = random
  end

  def start
    @store.set('delayer/moves', '')
    @store.set('delayer/dynamite_left', 100)
  end

  def move
    my_move = legal_moves[@random.rand(legal_moves.length)]
    @store.set('delayer/my_last_move', my_move)
    if my_move == 'DYNAMITE'
      dyn = @store.get('delayer/dynamite_left').to_i - 1
      @store.set('delayer/dynamite_left', dyn)
    end
    history = @store.get('delayer/moves') || ''
    history = "#{history}[#{my_move}"
    @store.set('delayer/moves', history)
    @store.set('delayer/awaiting_oppo', 'true')
    my_move
  end

  def opponents_move(move)
    history = @store.get('delayer/moves') || ''
    history = "#{history},#{move}]\n"
    @store.set('delayer/oppo_last_move', move)
    @store.set('delayer/moves', history)
    @store.set('delayer/awaiting_oppo', 'false')
  end

  def game_log
    @store.get('delayer/moves')
  end

  def awaiting_opponent
    @store.get('delayer/awaiting_oppo') == 'true'
  end

  def legal_moves
    result = ['ROCK', 'PAPER', 'SCISSORS']
    if @store.get('delayer/dynamite_left').to_i > 0
      result << 'DYNAMITE'
    end
    result
  end

end

