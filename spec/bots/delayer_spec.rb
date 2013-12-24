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

    context 'when the move is DYNAMITE' do
      let(:random) { double(:random, :rand => 3) }

      it 'decrements the dynamite available counter' do
        subject.move.should == 'DYNAMITE'
        store.get('delayer/dynamite_left').should == 9
      end
    end

    context 'when the move is not DYNAMITE' do

      it ' does not decrement the dynamite available counter' do
        subject.move.should == 'PAPER'
        store.get('delayer/dynamite_left').should == 10
      end
    end

  end

  context 'when there is no dynamite left' do

    before do
      store.set('delayer/dynamite_left', 0)
    end

    it 'cannot use dynamite' do
      subject.legal_moves.should == ['ROCK', 'PAPER', 'SCISSORS']
    end

  end

end
