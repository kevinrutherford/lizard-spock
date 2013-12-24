class RandomBot

  def initialize(random = Random.new)
    @random = random
  end

  def move(game_state)
    @game_state = game_state
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

