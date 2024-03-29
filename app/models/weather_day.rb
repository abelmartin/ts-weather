# frozen_string_literal: true

# Represents a day's weather data
class WeatherDay
  attr_reader :minTemp, :maxTemp, :humidity, :windSpeed, :windDirection, :weatherType, :date
  def initialize(payload)
    @payload = payload
  end

  # Returns the current temperature in Fahrenheit
  def c_to_f(temp)
    temp * 9 / 5 + 32
  end

  # Returns the current temperature in Celsius
  def f_to_c(temp)
    ((temp - 32) * 5 / 9).round(2)
  end
end
