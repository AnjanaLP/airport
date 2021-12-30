require 'airport'

describe Airport do
  subject(:airport)   { described_class.new }
  let(:plane)         { double :plane, land: nil, take_off: nil }

  describe '#capacity' do
    context 'when none given on initialize' do
      it 'returns the default capacity' do
        expect(airport.capacity).to eq described_class::DEFAULT_CAPACITY
      end
    end

    context 'when given on initialize' do
      subject(:small_airport)   { described_class.new(5) }
      it 'returns the specified capacity' do
        expect(small_airport.capacity).to eq 5
      end
    end
  end

  describe '#land' do
    it 'calls the land method on the plane' do
      expect(plane).to receive(:land).with(airport)
      airport.land(plane)
    end

    it "adds the plane to the airport's hangar" do
      airport.land(plane)
      expect(airport).not_to be_empty
    end

    context 'when full' do
      it 'raises an error' do
        airport.capacity.times { airport.land(plane) }
        message = "Cannot land plane: airport is full"
        expect { airport.land(plane) }.to raise_error message
      end
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
