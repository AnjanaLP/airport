class Airport
  DEFAULT_CAPACITY = 20

  attr_reader :weather, :capacity

  def initialize(weather, capacity=DEFAULT_CAPACITY)
    @weather = weather
    @capacity = capacity
    @hangar = []
  end

  def land(plane)
    raise "Cannot land plane: airport is full" if full?
    plane.land(self)
    add_to_hangar(plane)
  end

  def take_off(plane)
    raise "Cannot take off plane: weather is stormy" if weather.stormy?
    plane.take_off
    remove_from_hangar(plane)
  end

  def empty?
    hangar.empty?
  end

  private

  attr_reader :hangar

  def add_to_hangar(plane)
    hangar << plane
  end

  def remove_from_hangar(plane)
    hangar.delete(plane)
  end

  def full?
    hangar.count >= capacity
  end
end
