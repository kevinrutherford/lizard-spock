class LizardSpockBot

  def initialize(strategy, name, store)
    @strategy = strategy
    @name = name
    @game = GameStore.new(name, store)
  end

  def start(dynamite_count)
    @game['moves'] = ''
    @game['dynamite_left'] = dynamite_count
    @game['awaiting_oppo'] = 'false'
  end

  def move
    my_move = @strategy.move
    @game['my_last_move'] = my_move
    if my_move == 'DYNAMITE'
      dyn = @game['dynamite_left'].to_i - 1
      @game['dynamite_left'] = dyn
    end
    history = @game['moves'] || ''
    history = "#{history}[#{my_move}"
    @game['moves'] = history
    my_move
  end

  def opponents_move(move)
    history = @game['moves'] || ''
    history = "#{history},#{move}]\n"
    @game['oppo_last_move'] = move
    @game['moves'] = history
    @game['awaiting_oppo'] = 'false'
  end

  def game_log
    @game['moves']
  end

end

