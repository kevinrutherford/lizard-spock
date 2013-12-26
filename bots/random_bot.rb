class RandomBot

  def initialize(random = Random.new)
    @random = random
  end

  def move(game)
    legal_moves = ['ROCK', 'PAPER', 'SCISSORS']
    legal_moves << 'DYNAMITE' if game.dynamite_left > 0
    legal_moves[@random.rand(legal_moves.length)]
  end

end

