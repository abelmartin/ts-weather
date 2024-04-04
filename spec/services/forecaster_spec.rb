# frozen_string_literal: true

require 'rails_helper'
require 'geocoder/results/nominatim'

RSpec.describe Forecaster do
  subject { described_class }

  describe '.call' do
    let(:address) { 'Washington, DC' }
    let(:geocode_json) { File.read('spec/fixtures/geocode.json') }
    let(:forecast_json) { File.read('spec/fixtures/forecast.json') }
    let(:current_day) { File.read('spec/fixtures/current_day.json') }

    before do
      stub_request(:get, /openstreetmap/).to_return(body: geocode_json)
      stub_request(:get, /openweathermap.*forecast/). to_return(body: forecast_json)
      stub_request(:get, /openweathermap.*weather/). to_return(body: current_day)
    end

    it 'returns expected weather response' do
      expect(subject.call(address)).to match({
        location: 'Washington, District of Columbia, United States',
        current: be_kind_of(OpenWeatherMap::WeatherConditions),
        lat_lon: [38.8950368, -77.0365427],
        days: be_kind_of(Hash)
      })
    end

    it 'the exepected hash in the days key' do
      result = subject.call(address)
      expect(result[:days].keys).to all(be_kind_of(Date))
      expect(result[:days].values).to all(
        be_kind_of(Array).and(all(be_kind_of(OpenWeatherMap::WeatherConditions)))
      )
    end
  end
end
