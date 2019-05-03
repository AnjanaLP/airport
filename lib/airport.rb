class Airport
  DEFAULT_CAPACITY = 5

  attr_reader :planes

  def initialize(weather, capacity = DEFAULT_CAPACITY)
    @weather = weather
    @capacity = capacity
    @planes = []
  end

  def land(plane)
    raise "Cannot land plane, airport is full" if full?
    raise "Cannot land plane, weather is stormy" if stormy?
    plane.land(self)
    add_to_planes(plane)
  end

  def take_off(plane)
    raise "Cannot take_off plane, weather is stormy" if stormy?
    raise "Cannot take off plane, plane at a different airport" unless at_airport?(plane)
    plane.take_off
    remove_from_planes(plane)
  end

  private

  attr_reader :capacity, :weather

  def full?
    planes.length >= capacity
  end

  def add_to_planes(plane)
    planes << plane
  end

  def stormy?
    weather.stormy?
  end

  def at_airport?(plane)
    planes.include?(plane)
  end

  def remove_from_planes(plane)
    planes.pop
  end
end
