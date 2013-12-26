require_relative '../../hash_store'
require_relative '../../bots/lizard_spock_bot'

describe LizardSpockBot do
  let(:game) { Game.new('fred', HashStore.new) }
  let(:strategy) { double(:strategy, move: 'DYNAMITE') }
  subject { LizardSpockBot.new(strategy, game) }

  before do
    subject.start('oppo', 50)
  end

  context 'at game start' do
    it 'has no previous oppo last move' do
      expect(game['oppo_last_move']).to be == ''
    end
  end

  describe '#move' do

    it 'returns the strategys move' do
      subject.move.should == 'DYNAMITE'
    end

    context 'when the move is DYNAMITE' do

      it 'decrements the dynamite available counter' do
        subject.move
        game['dynamite_left'].should == 49
      end
    end

    context 'when the move is not DYNAMITE' do

      it 'does not decrement the dynamite available counter' do
        game['dynamite_left'].should == 50
      end
    end

  end
end

