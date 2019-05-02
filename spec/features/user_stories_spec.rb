describe 'User Stories' do

  # As an air traffic controller
  # So planes can land safely at my airport
  # I would like to instruct a plane to land
  it 'airport instructs a plane to land' do
    airport = Airport.new(10)
    plane = Plane.new
    expect { airport.land(plane) }.not_to raise_error
  end

  # As an air traffic controller
  # So planes can take off safely from my airport
  # I would like to instruct a plane to take off
  it 'airport instructs a plane to take off' do
    airport = Airport.new(10)
    plane = Plane.new
    expect { airport.take_off(plane) }.not_to raise_error
  end

  # As an air traffic controller
  # So that I can avoid collisions
  # I want to prevent airplanes landing when my airport is full
  it 'airport prevents planes landing when aiport is full' do
    airport = Airport.new(10)
    plane = Plane.new
    10.times { airport.land(plane) }
    expect { airport.land(plane) }.to raise_error "Cannot land plane, airport is full"
  end
end
