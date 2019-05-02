class Airport

  def initialize(capacity)
    @planes = []
    @capacity = capacity
  end

  def land(plane)
    raise "Cannot land plane, airport is full" if full?
    add_plane(plane)
  end

  def take_off(plane)
  end

  private

  attr_reader :planes, :capacity

  def full?
    planes.length >= capacity
  end

  def add_plane(plane)
    planes << plane
  end
end
