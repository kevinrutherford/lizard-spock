require_relative '../../bots/game_store'
require_relative '../../hash_store'

describe GameStore do

  let(:store) { HashStore.new }
  subject { GameStore.new('fred', store) }
  let(:thing) { { a: 12, b: 'xyzzy' } }

  before do
    subject['thing'] = thing
  end

  it 'can retrieve a stored value' do
    expect(subject['thing']).to be == thing
  end

  context 'when two game stores share the same underlying store' do

    let(:jim) { GameStore.new('jim', store) }

    it 'keeps their values separate' do
      jim['thing'] = 42
      expect(subject['thing']).to be == thing
      expect(jim['thing']).to be == 42
    end

  end

end
