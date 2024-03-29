# frozen_string_literal: true

# Generates instances of WeatherDay objects
class WeatherDayFactory
  def self.build(payload)
    WeatherDay.new(payload)
  end
end
