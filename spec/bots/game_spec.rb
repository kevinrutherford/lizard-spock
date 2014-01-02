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

  describe 'opponent dynamite' do
    context 'when he uses his last dynamite' do
      it 'reports no dynamite left' do
        subject.start('opponentName' => 'fred', 'dynamiteCount' => 1)
        expect(subject.oppo_can_use_dynamite?).to be true
        subject.oppo_move('DYNAMITE', 3)
        expect(subject.oppo_can_use_dynamite?).to be false
      end
    end

    context 'when he uses dynamite and has dynamite left' do
      it 'reports dynamite left' do
        subject.start('opponentName' => 'fred', 'dynamiteCount' => 33)
        expect(subject.oppo_can_use_dynamite?).to be true
        subject.oppo_move('DYNAMITE', 3)
        expect(subject.oppo_can_use_dynamite?).to be true
      end
    end

  end

end

