class Plane

  attr_reader :airport

  def land(airport)
    raise "Cannot land plane: plane has already landed" unless flying?
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
