# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Forecaster do
  include_context 'shared network context'

  subject { described_class }
  let(:address) { 'Washington, DC' }

  describe '.client' do
    it 'returns an instance of OpenWeatherMap::API' do
      expect(subject.client).to be_kind_of(OpenWeatherMap::API)
    end

    it 'has exepcted attributes' do
      expect(subject.client).to have_attributes(lang: 'en', units: 'imperial')
    end
  end

  describe '.call' do
    it 'returns expected weather response' do
      expect(subject.call(address)).to match(
        {
          location: 'Washington, District of Columbia, United States',
          current: be_kind_of(OpenWeatherMap::WeatherConditions),
          lat_lon: [38.8950368, -77.0365427],
          days: be_kind_of(Hash)
        }
      )
    end

    it 'the exepected hash in the days key' do
      result = subject.call(address)
      expect(result[:days].keys).to all(be_kind_of(Date))
      expect(result[:days].values).to all(
        be_kind_of(Array).and(all(be_kind_of(OpenWeatherMap::WeatherConditions)))
      )
    end

    it 'raises an error when the location is invalid' do
      allow(Geocoder).to receive(:search).and_return([])
      expect { subject.call('jjjxxjj') }.to raise_error(ForecasterError, 'Invalid location')
    end
  end

  describe '.lows_and_highs' do
    let(:forecast_days) { subject.client.forecast([0, 0]).forecast }
    let(:lows_and_highs_result) { subject.lows_and_highs(forecast_days) }
    # we'll evaluat 1 key/value set
    let(:tomorrow_values) { lows_and_highs_result[Date.tomorrow] }

    it "returns a hash without today's date." do
      expect(lows_and_highs_result.keys).not_to include(Date.today)
    end

    it 'returns keys that have arrays with 2 OpenWeatherMap::WeatherConditions items; the high & low of that day' do
      expect(tomorrow_values.count).to eq(2)

      # The first item in this array should be the lowest temp
      expect(tomorrow_values[0].temp_min).to be < tomorrow_values[1].temp_min
    end

    it 'returns the first item in a day\'s array for a day as the lowest temp of all the hours' do
      # the first item should be the lowest temp across all of the temp_min for a given day.
      expect(tomorrow_values[0].temp_min).to eq(
        forecast_days.filter { |day| day.time.to_date == Date.tomorrow }
        .min_by(&:temp_min).temp_min
      )
    end

    it 'returns the last item in a day\'s array for a day as the highest temp of all the hours' do
      # the first item should be the lowest temp across all of the temp_min for a given day.
      expect(tomorrow_values[1].temp_max).to eq(
        forecast_days.filter { |day| day.time.to_date == Date.tomorrow }
        .max_by(&:temp_max).temp_max
      )
    end
  end
end
