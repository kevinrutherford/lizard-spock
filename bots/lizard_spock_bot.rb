require_relative 'game'

class LizardSpockBot

  def initialize(strategy, game)
    @strategy = strategy
    @game = game
  end

  def start(oppo_name, dynamite_count)
    @game['startTime'] = Time.now
    @game['oppo_name'] = oppo_name
    @game['log'] = ''
    @game['dynamite_left'] = dynamite_count
    @game['oppo_last_move'] = ''
  end

  def move
    my_move = @strategy.move(self)
    @game['my_last_move'] = my_move
    if my_move == 'DYNAMITE'
      dyn = @game['dynamite_left'].to_i - 1
      @game['dynamite_left'] = dyn
    end
    history = @game['log'] || ''
    history = "#{history}{me: #{my_move}"
    @game['log'] = history
    my_move
  end

  def opponents_move(move)
    history = @game['log'] || ''
    history = "#{history}, him: #{move}}\n"
    @game['oppo_last_move'] = move
    @game['log'] = history
  end

  def game_log
    @game['log']
  end

  #- - - callbacks - - -

  def dynamite_left
    @game['dynamite_left'].to_i
  end

  def oppo_last_move
    @game['oppo_last_move']
  end

end

