# frozen_string_literal: true

class Forecaster
  URI = URI('https://api.weather.gov/points/')
  # https://api.weather.gov/points/{lat},{lon}
  def self.get_forecast(address)
    coordinates = AddressVerifier.coordinates(address)
    return unless coordinates.present?

    # Call the API and return the weather
    request = Net::HTTP::Get.new(URI + coordinates.join(','))
    request['Accept'] = 'application/ld+json'
    request['User-Agent'] = ENV.fetch('NOAA_AGENT', nil)

    res = Net::HTTP.start(URI.hostname, URI.port, use_ssl: true) { |http| http.request(request) }
    if res.is_a?(Net::HTTPPermanentRedirect)
    binding.pry
    # Rails.cache.write
  end
end
