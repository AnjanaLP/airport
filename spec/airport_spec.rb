require 'airport'

describe Airport do
  subject(:airport) { described_class.new(10, weather) }
  let(:plane)       { double :plane }
  let(:weather)     { double :weather }

  describe '#land' do
    context 'when not stormy' do
      before do
        allow(weather).to receive(:stormy?).and_return(false)
      end

      it 'instructs a plane to land' do
        expect(airport).to respond_to(:land).with(1).argument
      end

      context 'when full' do
        it 'raises an error' do
          10.times { airport.land(plane) }
          expect { airport.land(plane) }.to raise_error "Cannot land plane, airport is full"
        end
      end
    end

    context 'when stormy' do
      it 'raises an error' do
        allow(weather).to receive(:stormy?).and_return(true)
        expect { airport.land(plane) }.to raise_error "Cannot land plane, weather is stormy"
      end
    end
  end


  describe '#take_off' do
    context 'when not stormy' do
      it 'instructs a plane to take off' do
        allow(weather).to receive(:stormy?).and_return(false)
        expect(airport).to respond_to(:take_off).with(1).argument
      end
    end

    context 'when stormy' do
      it 'raises an error' do
        allow(weather).to receive(:stormy?).and_return(true)
        expect { airport.take_off(plane) }.to raise_error "Cannot take_off plane, weather is stormy"
      end
    end
  end
end
