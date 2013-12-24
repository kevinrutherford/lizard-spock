class Delayer

  def initialize(store, random = Random.new)
    @store = store
    @random = random
  end

  def move
    legal_moves[@random.rand(legal_moves.length)]
  end

  def legal_moves
    result = ['ROCK', 'PAPER', 'SCISSORS']
    if @store.get('delayer/dynamite_left').to_i > 0
      result << 'DYNAMITE'
    end
    result
  end

end

