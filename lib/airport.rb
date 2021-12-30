class Airport
  DEFAULT_CAPACITY = 20

  attr_reader :capacity

  def initialize(weather, capacity=DEFAULT_CAPACITY)
    @weather = weather
    @capacity = capacity
    @hangar = []
  end

  def land(plane)
    raise "Cannot land plane: weather is stormy" if stormy?
    raise "Cannot land plane: airport is full" if full?
    plane.land(self)
    add_to_hangar(plane)
  end

  def take_off(plane)
    raise "Cannot take off plane: weather is stormy" if stormy?
    plane.take_off
    remove_from_hangar(plane)
  end

  def empty?
    hangar.empty?
  end

  private

  attr_reader :hangar, :weather

  def add_to_hangar(plane)
    hangar << plane
  end

  def remove_from_hangar(plane)
    hangar.delete(plane)
  end

  def full?
    hangar.count >= capacity
  end

  def stormy?
    weather.stormy?
  end
end
