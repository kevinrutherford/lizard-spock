require_relative '../../hash_store'
require_relative '../../bots/delayer'

describe Delayer do
  let(:random) { double(:random, :rand => 1) }
  let(:store) { HashStore.new }
  subject { Delayer.new(store, random) }

  context 'when there is dynamite available' do

    before do
      store.set('delayer/dynamite_left', 10)
    end

    it 'can use dynamite' do
      subject.legal_moves.should == ['ROCK', 'PAPER', 'SCISSORS', 'DYNAMITE']
    end

  end

  context 'when there is no dynamite left' do

    before do
      store.set('delayer/dynamite_left', 0)
    end

    it 'cannot use dynamite' do
      subject.legal_moves.should == ['ROCK', 'PAPER', 'SCISSORS']
    end

    context 'when the oppo has already played' do
      before do
        store.set('delayer/oppo_last_move', 'PAPER')
      end

      it 'plays a guaranteed winner' do
        expect(subject.move).to be == 'SCISSORS'
      end
    end

  end

end
