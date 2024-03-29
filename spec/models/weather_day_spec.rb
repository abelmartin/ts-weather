# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherDay do
  let(:payload) do
    {}
  end
  subject { described_class.new(payload) }

  describe '#initialize' do
    it 'returns a WeatherDay object' do
      expect(subject.current_temp).to eq(90)
    end
  end
end
