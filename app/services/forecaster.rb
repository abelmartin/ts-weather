# frozen_string_literal: true

# Makse a request to the NOAA API to get the weather forecast for a given address
class Forecaster
  def self.client
    @client ||= OpenWeatherMap::API.new(
      ENV.fetch('OPEN_WEATHER_MAP_API_KEY', nil),
      'en',
      'imperial'
    )
  end

  def self.call(location)
    geopoints = Geocoder.search(location)
    raise ForecastError, 'Invalid location' if geopoints.empty?

    geopoint = geopoints.first

    days = client.forecast(geopoint.coordinates.reverse).forecast

    {
      location: geopoint.address,
      lat_lon: geopoint.coordinates,
      current: client.current(geopoint.coordinates.reverse).weather_conditions,
      days: lows_and_highs(days)
    }
  end

  def self.lows_and_highs(forecast_days)
    # We'll exclude the current day since we have another API call for that
    forecast_days = forecast_days.reject{|d| d.time.to_date == Date.today}

    # Let's start by grouping the days by date
    grouped_days = forecast_days.group_by { |day| day.time.to_date }

    # Next we'll capture the min/max for each day, stored in a new hash with dates as the keys
    # In this output the `temp_min` and `temp_max` are the same number
    minmax_days = {}
    grouped_days.each do |day, days|
      minmax_days[day] = days.minmax_by(&:temp_min)
    end

    # Return the required hash
    minmax_days
  end
end
