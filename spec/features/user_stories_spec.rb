describe 'User Stories' do
  let(:airport)   { Airport.new }
  let(:plane)     { Plane.new }
  # As an air traffic controller
  # So I can get passengers to a destination
  # I want to instruct a plane to land at an airport
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

  # As an air traffic controller
  # To ensure safety
  # I want to prevent landing when the airport is full
  it 'an airport prevents landing when it is full' do
    airport.capacity.times { airport.land(plane) }
    message = "Cannot land plane: airport is full"
    expect { airport.land(plane) }.to raise_error message
  end

  # As the system designer
  # So that the software can be used for many different airports
  # I would like a default airport capacity that can be overridden as appropriate
  it 'an airport has a default capacity' do
    expect(airport.capacity).to eq Airport::DEFAULT_CAPACITY
  end

  it 'the default capacity can be overridden on initialize' do
    small_airport = Airport.new(5)
    expect(small_airport.capacity).to eq 5
  end
end
