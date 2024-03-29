# frozen_string_literal: true

# Makse a request to the NOAA API to get the weather forecast for a given address
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
    # if res.is_a?(Net::HTTPPermanentRedirect)
    binding.pry
    # Rails.cache.write
  end

  def self.call(address)
    coordinates = AddressVerifier.coordinates(address) if AddressVerifier.valid?(address)

    conn.get("/points/#{coordinates.join(',')}").body
  end

  def self.conn
    @conn ||= Faraday.new(
      url: 'https://api.weather.gov',
      headers: {
        'User-Agent' => ENV.fetch('NOAA_AGENT', nil),
        'Accept' => 'application/ld+json'
      }
    ) do |req|
      # req.use FaradayMiddleware::FollowRedirects
      req.use Faraday::FollowRedirects::Middleware
      req.response :json
    end
  end
end
