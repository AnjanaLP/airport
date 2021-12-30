require 'weather'

describe Weather do
  subject(:weather)   { described_class.new }

  describe '#stormy?' do
    context 'when stormy' do
      it 'returns true' do
        allow(described_class::OUTLOOKS).to receive(:sample).and_return :stormy
        expect(weather).to be_stormy
      end
    end

    context 'when sunny' do
      it 'returns false' do
        allow(described_class::OUTLOOKS).to receive(:sample).and_return :sunny
        expect(weather).not_to be_stormy
      end
    end
  end
end
