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

  def moves_that_lose_to(move, dynamite_allowed)
    case move
    when 'ROCK'
      ['SCISSORS', 'WATERBOMB']
    when 'PAPER'
      ['ROCK', 'WATERBOMB']
    when 'SCISSORS'
      ['PAPER', 'WATERBOMB']
    when 'DYNAMITE'
      ['ROCK', 'PAPER', 'SCISSORS']
    when 'WATERBOMB'
      ['DYNAMITE']
    end
  end

end

