class Airport

  def initialize
    @hangar = []
  end

  def land(plane)
    plane.land(self)
    add_to_hangar(plane)
  end

  def take_off(plane)
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
end
