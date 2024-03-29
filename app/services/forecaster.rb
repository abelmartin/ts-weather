# frozen_string_literal: true

# Makse a request to the NOAA API to get the weather forecast for a given address
class Forecaster
  def self.call(location)
    geopoints = Geocoder.search(location)
    raise ForecastError, 'Invalid location' if geopoints.empty?

    # binding.pry
    OpenWeatherMap::API.new(
      ENV.fetch('OPEN_WEATHER_MAP_API_KEY', nil),
      'en',
      'imperial'
    ).forecast(geopoints.first.coordinates)
  end
end
