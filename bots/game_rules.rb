class GameRules

  def moves_that_beat(move, dynamite_allowed)
    dynamite = dynamite_allowed ? ['DYNAMITE'] : []
    case move
    when 'ROCK'
      ['PAPER'] + dynamite
    when 'PAPER'
      ['SCISSORS'] + dynamite
    when 'SCISSORS'
      ['ROCK'] + dynamite
    when 'DYNAMITE'
      ['WATERBOMB']
    when 'WATERBOMB'
      ['ROCK', 'PAPER', 'SCISSORS']
    end
  end

end

