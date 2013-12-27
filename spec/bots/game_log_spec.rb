require_relative '../../bots/game_log'
require_relative '../../bots/game'
require_relative '../../hash_store'

describe GameLog do

  subject { GameLog.new(Game.new('fred', HashStore.new)) }

  before do
    subject.clear
  end

  context 'clearing the log' do
    it 'sets it to empty' do
      expect(subject.all_items).to be == []
    end
  end

  context 'recording an item' do
    before do
      subject.record('abc def')
    end

    it 'has only one record' do
      expect(subject.all_items.length).to be == 1
    end

    it 'records the item' do
      expect(subject.all_items[0]).to match(/abc def/)
    end
  end

  context 'recording several items' do
    before do
      subject.record('abc def')
      subject.record('ghi jkl')
      subject.record('mno pqr')
    end

    it 'has three records' do
      expect(subject.all_items.length).to be == 3
    end

    it 'records the items in order' do
      expect(subject.all_items[0]).to match(/abc def/)
      expect(subject.all_items[1]).to match(/ghi jkl/)
      expect(subject.all_items[2]).to match(/mno pqr/)
    end
  end

end

