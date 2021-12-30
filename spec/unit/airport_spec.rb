require 'airport'

describe Airport do
  subject(:airport)   { described_class.new }
  let(:plane)         { double :plane, land: nil, take_off: nil }

  describe '#land' do
    it 'calls the land method on the plane' do
      expect(plane).to receive(:land).with(airport)
      airport.land(plane)
    end

    it "adds the plane to the airport's hangar" do
      airport.land(plane)
      expect(airport).not_to be_empty
    end
  end

  describe '#take_off' do
    it 'calls the take_off method on the plane' do
      airport.land(plane)
      expect(plane).to receive(:take_off)
      airport.take_off(plane)
    end

    it "removes the plane from the airport's hangar" do
      airport.land(plane)
      airport.take_off(plane)
      expect(airport).to be_empty
    end
  end
end
