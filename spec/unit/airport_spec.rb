require 'airport'

describe Airport do
  subject(:airport)   { described_class.new(weather) }
  let(:plane)         { double :plane, land: nil, take_off: nil }
  let(:weather)       { double :weather }

  describe '#capacity' do
    context 'when none given on initialize' do
      it 'returns the default capacity' do
        expect(airport.capacity).to eq described_class::DEFAULT_CAPACITY
      end
    end

    context 'when given on initialize' do
      subject(:small_airport)   { described_class.new(weather, 5) }
      it 'returns the specified capacity' do
        expect(small_airport.capacity).to eq 5
      end
    end
  end

  describe '#land' do
    context 'when sunny' do
      before { allow(weather).to receive(:stormy?).and_return false }

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

    context 'when stormy' do
      it 'raises an error' do
        allow(weather).to receive(:stormy?).and_return true
        message = "Cannot land plane: weather is stormy"
        expect { airport.land(plane) }.to raise_error message
      end
    end
  end

  describe '#take_off' do
    before do
      allow(weather).to receive(:stormy?).and_return false
    end

    context 'when sunny' do
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

      context 'when plane is at another airport' do
        it 'raises an error' do
          other_airport = described_class.new(weather)
          other_airport.land(plane)
          allow(plane).to receive(:airport).and_return other_airport
          message = "Cannot take off plane: plane is at another airport"
          expect { airport.take_off(plane) }.to raise_error message
        end
      end
    end

    context 'when stormy' do
      it 'raises an error' do
        allow(weather).to receive(:stormy?).and_return true
        message = "Cannot take off plane: weather is stormy"
        expect { airport.take_off(plane) }.to raise_error message
      end
    end
  end
end
