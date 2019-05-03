describe 'User Stories' do

  let(:airport) { Airport.new(weather, 10) }
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
        10.times do
          the_plane = Plane.new
          airport.land(the_plane)
        end
        expect { airport.land(plane) }.to raise_error "Cannot land plane, airport is full"
      end
    end

    # As an air traffic controller
    # So that I can ensure safe take off procedures
    # I want planes only to take off from the airport they are at
    it 'planes can only take off from the airport they are at' do
      other_airport = Airport.new(weather, 15)
      other_airport.land(plane)
      expect { airport.take_off(plane) }.to raise_error "Cannot take off plane, plane at a different airport"
    end

    # As the system designer
    # So that the software can be used for many different airports
    # I would like a default airport capacity that can be overridden as appropriate
    it 'airports have a default capacity' do
      default_airport = Airport.new(weather)
      Airport::DEFAULT_CAPACITY.times do
        the_plane = Plane.new
        default_airport.land(the_plane)
      end
      expect { default_airport.land(plane) }.to raise_error "Cannot land plane, airport is full"
    end

    # As an air traffic controller
    # So the system is consistent and correctly reports plane status and location
    # I want to ensure a flying plane cannot take off and cannot be in an airport
    it 'flying planes cannot take off' do
      expect { plane.take_off }.to raise_error "Plane cannot take off, plane is flying"
    end

    it 'flying planes cannot be in an airport' do
      expect { plane.airport }.to raise_error "Plane is not in an airport, plane is flying"
    end

    # As an air traffic controller
    # So the system is consistent and correctly reports plane status and location
    # I want to ensure a plane that is not flying cannot land and must be in an airport
    it 'landed planes cannot land' do
      airport.land(plane)
      expect { plane.land(airport) }.to raise_error "Plane cannot land, plane already landed"
    end

    it 'landed planes must be in an airport' do
      airport.land(plane)
      expect(plane.airport).to eq airport
    end

    # As an air traffic controller
    # So the system is consistent and correctly reports plane status and location,
    # I want to ensure a plane that has taken off from an airport is no longer in that airport
    it 'planes are no longer in the airport they took off from' do
      airport.land(plane)
      airport.take_off(plane)
      expect(airport.planes).not_to include(plane)
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
