# frozen_string_literal: true

RSpec.shared_context 'shared network context' do
  let(:geocode_json) { File.read('spec/fixtures/geocode.json') }
  let(:forecast_json) { File.read('spec/fixtures/forecast.json') }
  let(:current_day) { File.read('spec/fixtures/current_day.json') }

  before do
    stub_request(:get, /openstreetmap/).to_return(body: geocode_json)
    stub_request(:get, /openweathermap.*forecast/).to_return(body: forecast_json)
    stub_request(:get, /openweathermap.*weather/).to_return(body: current_day)
  end
end
