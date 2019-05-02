require 'weather'

describe Weather do
  subject(:weather) { described_class.new }

  describe '#stormy?' do
    it 'can be stormy' do
      allow(Kernel).to receive(:rand).and_return(6)
      expect(weather).to be_stormy
    end

    it 'can be non-stormy' do
      allow(Kernel).to receive(:rand).and_return(1)
      expect(weather).not_to be_stormy
    end
  end
end
