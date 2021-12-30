describe 'User Stories' do
  let(:airport)   { Airport.new(weather) }
  let(:weather)   { Weather.new }
  let(:plane)     { Plane.new }

  # As an air traffic controller
  # So I can get passengers to a destination
  # I want to instruct a plane to land at an airport
  context 'when sunny' do
    before { allow(weather).to receive(:stormy?).and_return false }

    it 'an airport instructs a plane to land' do
      expect { airport.land(plane ) }.not_to raise_error
    end

    it 'a plane is at the airport it has landed at' do
      airport.land(plane)
      expect(plane.airport).to eq airport
    end

    it "an airport has a landed plane in it's hangar" do
      airport.land(plane)
      expect(airport).not_to be_empty
    end

    # As an air traffic controller
    # So I can get passengers on the way to their destination
    # I want to instruct a plane to take off from an airport and confirm that it is no longer in the airport
    it 'an airport instructs a plane to take off' do
      airport.land(plane)
      expect { airport.take_off(plane ) }.not_to raise_error
    end

    it 'a taken off plane is not at an airport' do
      airport.land(plane)
      airport.take_off(plane)
      expect(plane.airport).to be_nil
    end

    it "an airport does not have a taken off plane in it's hangar" do
      airport.land(plane)
      airport.take_off(plane)
      expect(airport).to be_empty
    end

    it 'a plane can only take off from the airport they are in' do
      airport.land(plane)
      other_airport = Airport.new(weather)
      message = "Cannot take off plane: plane is at another airport"
      expect { other_airport.take_off(plane) }.to raise_error message
    end

    it 'a plane that is already flying cannot take off' do
      message = "Plane cannot take off: plane is already flying"
      expect { plane.take_off }.to raise_error message
    end

    it 'a plane that is already flying cannot be in an airport' do
      plane.land(airport)
      plane.take_off
      expect(plane.airport).to be_nil
    end

    # As an air traffic controller
    # To ensure safety
    # I want to prevent landing when the airport is full
    it 'an airport prevents landing when it is full' do
      airport.capacity.times { airport.land(plane) }
      message = "Cannot land plane: airport is full"
      expect { airport.land(plane) }.to raise_error message
    end
  end

  # As the system designer
  # So that the software can be used for many different airports
  # I would like a default airport capacity that can be overridden as appropriate
  it 'an airport has a default capacity' do
    expect(airport.capacity).to eq Airport::DEFAULT_CAPACITY
  end

  it 'the default capacity can be overridden on initialize' do
    small_airport = Airport.new(weather, 5)
    expect(small_airport.capacity).to eq 5
  end

  # As an air traffic controller
  # To ensure safety
  # I want to prevent takeoff when weather is stormy
  context 'when stormy' do
    before do
      allow(weather).to receive(:stormy?).and_return false
      airport.land(plane)
      allow(weather).to receive(:stormy?).and_return true
    end

    it 'an airport prevents take off' do
      message = "Cannot take off plane: weather is stormy"
      expect { airport.take_off(plane) }.to raise_error message
    end

    # As an air traffic controller
    # To ensure safety
    # I want to prevent landing when weather is stormy
    it 'an airport prevents landing' do
      message = "Cannot land plane: weather is stormy"
      expect { airport.land(plane) }.to raise_error message
    end
  end
end
