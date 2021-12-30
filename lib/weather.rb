class Weather
  OUTLOOKS = [:sunny, :sunny, :stormy, :sunny]

  def stormy?
    random_weather == :stormy
  end

  private

  def random_weather
    OUTLOOKS.sample
  end
end
