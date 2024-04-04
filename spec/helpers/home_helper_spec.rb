# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the HomeHelper. For example:
#
# describe HomeHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe HomeHelper, type: :helper do
  before do
    @forecast = {
      lat_lon: [40.7128, -74.0060],
      cache_ttl: 3600
    }
  end

  describe '#map_url' do
    it 'returns the expected string' do
      expect(helper.map_url).to eq(
        'https://www.openstreetmap.org/export/embed.html?bbox=-74.006%2C40.7128%2C-74.006%2C40.7128'
      )
    end
  end

  describe '#map_link' do
    it 'returns the expected string' do
      expect(helper.map_link).to eq('https://www.openstreetmap.org/#map=13/40.7128/-74.006')
    end
  end

  describe '#temp' do
    it 'returns the expected string' do
      expect(helper.temp(75)).to eq('75°F')
    end
  end

  describe '#humanized_cache_ttl' do
    it 'returns correctly pluralized minutes and seconds when appropriate' do
      @forecast[:cache_ttl] = 125
      expect(helper.humanized_cache_ttl).to eq('2 minutes, 5 seconds')
    end

    it 'returns only seconds when the ttl is less than a minute' do
      @forecast[:cache_ttl] = 30
      expect(helper.humanized_cache_ttl).to eq('30 seconds')
    end
  end
end
