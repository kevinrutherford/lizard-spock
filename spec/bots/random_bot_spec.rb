require_relative '../../hash_store'
require_relative '../../bots/random_bot'

describe RandomBot do
  let(:random) { double(:random, :rand => 1) }
  let(:store) { HashStore.new }
  subject { RandomBot.new(store, random) }

  context 'when there is dynamite available' do

    before do
      store.set('random/dynamite_left', 10)
    end

    it 'can use dynamite' do
      subject.legal_moves.should == ['ROCK', 'PAPER', 'SCISSORS', 'DYNAMITE']
    end

  end

  context 'when there is no dynamite left' do

    before do
      store.set('random/dynamite_left', 0)
    end

    it 'cannot use dynamite' do
      subject.legal_moves.should == ['ROCK', 'PAPER', 'SCISSORS']
    end

  end

end
