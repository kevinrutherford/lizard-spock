require_relative '../../hash_store'
require_relative '../../bots/random_bot'

describe RandomBot do
  let(:random) { double(:random, :rand => 1) }
  let(:state) { double(:state, dynamite_left: 3) }
  subject { RandomBot.new(random) }

  it 'generates a valid move' do
    expect(subject.move(state)).to be == 'PAPER'
  end

end
