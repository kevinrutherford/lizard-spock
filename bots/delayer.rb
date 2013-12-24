class Delayer

  def initialize(store, random = Random.new)
    @store = store
    @random = random
  end

  def move
    his = @store.get("delayer/oppo_last_move")
    if his && his.length > 0
      my = GameRules.new.moves_that_beat(his, dynamite_allowed?)
      if my.length > 0
        return my[0]
      end
    end
    legal_moves[@random.rand(legal_moves.length)]
  end

  def legal_moves
    result = ['ROCK', 'PAPER', 'SCISSORS']
    if dynamite_allowed?
      result << 'DYNAMITE'
    end
    result
  end

  def dynamite_allowed?
    @store.get('delayer/dynamite_left').to_i > 0
  end

end

