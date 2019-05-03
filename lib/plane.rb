class Plane

  def initialize
    @flying = true
  end

  def take_off
    raise "Plane cannot take off, plane is flying" if @flying
  end

  def airport
    raise "Plane is not in an airport, plane is flying" if @flying
    @airport
  end

  def land(airport)
    raise "Plane cannot land, plane already landed" unless @flying
    @flying = false
    @airport = airport
  end
end
