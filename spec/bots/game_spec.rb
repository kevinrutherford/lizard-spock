require_relative '../../bots/game'

describe Game do

  let(:random) { double(:random, rand: 1) }
  subject { Game.new(random) }

  describe 'random_move' do

    it 'returns PAPER' do
      subject.start('opponentName' => 'dick', 'dynamiteCount' => '20')
      expect(subject.random_move).to be == 'PAPER'
    end
  end

end

