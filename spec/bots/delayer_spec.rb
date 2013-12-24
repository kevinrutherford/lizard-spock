require_relative '../../hash_store'
require_relative '../../bots/delayer'

describe Delayer do
  let(:random) { double(:random, :rand => 1) }
  let(:state) { double(:game_state, oppo_last_move: 'PAPER', dynamite_left: 0) }
  subject { Delayer.new(random) }

  context 'when there is no dynamite left' do

    context 'when the oppo has already played' do

      it 'plays a guaranteed winner' do
        expect(subject.move(state)).to be == 'SCISSORS'
      end
    end

  end

end
