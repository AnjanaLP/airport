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
      plane.take_off
      expect(plane.airport).to eq nil
    end
  end
end
