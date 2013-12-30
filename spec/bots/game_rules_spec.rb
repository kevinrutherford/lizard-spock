require_relative '../../bots/game_rules'

describe GameRules do

  context 'when dynamite is allowed' do

    {
      'ROCK'       => ['PAPER', 'DYNAMITE'],
      'PAPER'      => ['SCISSORS', 'DYNAMITE'],
      'SCISSORS'   => ['ROCK', 'DYNAMITE'],
      'DYNAMITE'   => ['WATERBOMB'],
      'WATERBOMB'  => ['ROCK', 'PAPER', 'SCISSORS'],
    }.each do |move, expected|
      it "knows what beats #{move}" do
        expect(subject.moves_that_beat(move, true)).to be == expected
      end
    end

    {
      'ROCK'       => ['SCISSORS', 'WATERBOMB'],
      'PAPER'      => ['ROCK', 'WATERBOMB'],
      'SCISSORS'   => ['PAPER', 'WATERBOMB'],
      'DYNAMITE'   => ['ROCK', 'PAPER', 'SCISSORS'],
      'WATERBOMB'  => ['DYNAMITE'],
    }.each do |move, expected|
      it "knows what loses to #{move}" do
        expect(subject.moves_that_lose_to(move, true)).to be == expected
      end
    end

  end

  context 'when dynamite is NOT allowed' do

    {
      'ROCK'       => ['PAPER'],
      'PAPER'      => ['SCISSORS'],
      'SCISSORS'   => ['ROCK'],
      'DYNAMITE'   => ['WATERBOMB'],
      'WATERBOMB'  => ['ROCK', 'PAPER', 'SCISSORS'],
    }.each do |move, expected|
      it "knows what beats #{move}" do
        expect(subject.moves_that_beat(move, false)).to be == expected
      end
    end

    {
      'ROCK'       => ['SCISSORS', 'WATERBOMB'],
      'PAPER'      => ['ROCK', 'WATERBOMB'],
      'SCISSORS'   => ['PAPER', 'WATERBOMB'],
      'DYNAMITE'   => ['ROCK', 'PAPER', 'SCISSORS'],
      'WATERBOMB'  => ['DYNAMITE'],
    }.each do |move, expected|
      it "knows what loses to #{move}" do
        expect(subject.moves_that_lose_to(move, false)).to be == expected
      end
    end

  end

end

