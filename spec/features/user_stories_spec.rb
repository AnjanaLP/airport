describe 'User Stories' do

  let(:airport) { Airport.new(10, weather) }
  let(:plane)   { Plane.new }
  let(:weather) { Weather.new }

  context 'when weather is not stormy' do
    before do
      allow(weather).to receive(:stormy?).and_return(false)
    end

    # As an air traffic controller
    # So planes can land safely at my airport
    # I would like to instruct a plane to land
    it 'airport instructs a plane to land' do
      expect { airport.land(plane) }.not_to raise_error
    end

    # As an air traffic controller
    # So planes can take off safely from my airport
    # I would like to instruct a plane to take off
    it 'airport instructs a plane to take off' do
      airport.land(plane)
      expect { airport.take_off(plane) }.not_to raise_error
    end

    # As an air traffic controller
    # So that I can avoid collisions
    # I want to prevent airplanes landing when my airport is full
    context 'when airport is full' do
      it 'airport prevents planes landing' do
        10.times { airport.land(plane) }
        expect { airport.land(plane) }.to raise_error "Cannot land plane, airport is full"
      end
    end

    # As an air traffic controller
    # So that I can ensure safe take off procedures
    # I want planes only to take off from the airport they are at
    it 'planes can only take off from the airport they are at' do
      other_airport = Airport.new(15, weather)
      other_airport.land(plane)
      expect { airport.take_off(plane) }.to raise_error "Cannot take off plane, plane at a different airport"
    end
  end

  # As an air traffic controller
  # So that I can avoid accidents
  # I want to prevent airplanes landing or taking off when the weather is stormy
  context 'when weather is stormy' do
    before do
      allow(weather).to receive(:stormy?).and_return(true)
    end

    it 'airport prevents planes landing' do
      expect { airport.land(plane) }.to raise_error "Cannot land plane, weather is stormy"
    end

    it 'airport prevents planes taking off' do
      expect { airport.take_off(plane) }.to raise_error "Cannot take_off plane, weather is stormy"
    end
  end
end
