require_relative 'game'
require_relative 'game_log'

class LizardSpockBot

  def initialize(strategy, game)
    @strategy = strategy
    @game = game
    @log = GameLog.new(@game)
  end

  def start(oppo_name, dynamite_count)
    @game['startTime'] = Time.now
    @game['oppo_name'] = oppo_name
    @log.clear
    @log.record "New game: opponent: #{oppo_name}"
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
    @log.record "my move: #{my_move}"
    my_move
  end

  def opponents_move(move, round)
    @game['oppo_last_move'] = move
    @log.record "his move (#{round}): #{move}"
  end

  def game_log
    @log.all_items
  end

  #- - - callbacks - - -

  def dynamite_left
    @game['dynamite_left'].to_i
  end

  def oppo_last_move
    @game['oppo_last_move']
  end

end

