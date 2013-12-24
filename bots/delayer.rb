require_relative 'game_rules'

class Delayer

  def initialize(random = Random.new)
    @random = random
  end

  def move(game_state)
    @game_state = game_state
    his = @game_state.oppo_last_move
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
    @game_state.dynamite_left > 0
  end

end

