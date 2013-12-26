require_relative '../../bots/game'
require_relative '../../hash_store'

describe Game do

  let(:store) { HashStore.new }
  subject { Game.new('fred', store) }
  let(:thing) { { a: 12, b: 'xyzzy' } }

  before do
    subject['thing'] = thing
  end

  it 'can retrieve a stored value' do
    expect(subject['thing']).to be == thing
  end

  context 'when two game stores share the same underlying store' do

    let(:jim) { Game.new('jim', store) }

    it 'keeps their values separate' do
      jim['thing'] = 42
      expect(subject['thing']).to be == thing
      expect(jim['thing']).to be == 42
    end

  end

  context 'logging' do
    it 'logs multiple things' do
      subject.log 'one'
      subject.log 'two'
      expect(subject.game_log[0]).to match(/one$/)
    end
  end

end

