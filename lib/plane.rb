class Plane

  attr_reader :airport

  def land(airport)
    @airport = airport
  end

  def take_off
    raise "Plane cannot take off: plane is already flying" if flying?
    @airport = nil
  end

  private

  def flying?
    airport.nil?
  end
end
