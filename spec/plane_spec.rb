require 'plane'

describe Plane do
  subject(:plane) { described_class.new }
  let(:airport)   { double :airport }

  describe '#take_off' do
    it { is_expected.to respond_to(:take_off) }

    it 'raises an error if plane is flying' do
      expect { plane.take_off }.to raise_error "Plane cannot take off, plane is flying"
    end
  end

  describe '#airport' do
    it { is_expected.to respond_to(:take_off) }

    it 'raises an error if plane is flying' do
      expect { plane.airport }.to raise_error "Plane is not in an airport, plane is flying"
    end
  end

  describe '#land' do
    it 'stores the airport the plane landed at' do
      plane.land(airport)
      expect(plane.airport).to eq airport
    end

    it 'raises an error if plane already landed' do
      plane.land(airport)
      expect { plane.land(airport) }.to raise_error "Plane cannot land, plane already landed"
    end
  end
end
1.47
