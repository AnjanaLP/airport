require 'plane'

describe Plane do
  subject(:plane)   { described_class.new }
  let(:airport)     { double :airport }

  describe '#land' do
    it 'sets the airport to where it has landed' do
      plane.land(airport)
      expect(plane.airport).to eq airport
    end
  end

  describe '#take_off' do
    it 'sets the airport it is at to nil' do
      plane.land(airport)
      plane.take_off
      expect(plane.airport).to eq nil
    end

    context 'when already flying' do
      it 'raises an error' do
        message = "Plane cannot take off: plane is already flying"
        expect { plane.take_off }.to raise_error message
      end
    end
  end
end
