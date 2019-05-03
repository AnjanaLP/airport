class Plane

  def initialize
    @flying = true
  end

  def take_off
    raise "Plane cannot take off, plane is flying" if flying
  end

  def airport
    raise "Plane is not in an airport, plane is flying" if flying
    @airport
  end

  def land(airport)
    raise "Plane cannot land, plane already landed" if landed
    @flying = false
    @airport = airport
  end

  private

  attr_reader :flying

  def landed
    !flying
  end
end
