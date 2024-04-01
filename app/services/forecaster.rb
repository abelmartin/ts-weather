# frozen_string_literal: true

# Makse a request to the NOAA API to get the weather forecast for a given address
class Forecaster
  def self.call(location)
    geopoints = Geocoder.search(location)
    raise ForecastError, 'Invalid location' if geopoints.empty?

    geopoint = geopoints.first
    key = cache_key(geopoint)
    Rails.logger.info "Cach Key: #{key}"

    # binding.pry
    days = OpenWeatherMap::API.new(
      ENV.fetch('OPEN_WEATHER_MAP_API_KEY', nil),
      'en',
      'imperial'
    ).forecast(geopoint.coordinates.reverse).forecast

    # binding.remote_pry
    # binding.pry
    {
      location: geopoint.address,
      cache_key: key,
      days: lows_and_highs(days),
      expiry_seconds: $redis.ttl(key)
    }
  end

  def self.cache_key(geopoint_result)
    state_region = if geopoint_result.country_code == 'us'
                     geopoint_result.state
                   else
                     geopoint_result.data.dig 'address', 'region'
                   end
    "#{geopoint_result.city} #{state_region} #{geopoint_result.country}"
  end

  def self.lows_and_highs(forecast_days)
    # Let's start by grouping the days by date
    grouped_days = forecast_days.group_by { |day| day.time.to_date }

    # Next we'll capture the min/max for each day, stored in a new hash with dates as the keys
    minmax_days = {}

    grouped_days.each do |day, days|
      minmax_days[day] = days.minmax_by(&:temp_min)
    end

    minmax_days
  end
end
