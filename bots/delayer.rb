require_relative 'game_rules'

class Delayer

  def initialize(random = Random.new)
    @random = random
  end

  def move(game)
    @game = game
    his = @game.oppo_last_move
    if his && his.length > 0
      my = GameRules.new.moves_that_beat(his, dynamite_allowed?)
      if my.length > 0
        return my[0]
      end
    end
    legal_moves[@random.rand(legal_moves.length)]
  end

  private

  def legal_moves
    result = ['ROCK', 'PAPER', 'SCISSORS']
    result << 'DYNAMITE' if dynamite_allowed?
    result
  end

  def dynamite_allowed?
    @game.dynamite_left > 0
  end

end

