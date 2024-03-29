# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Forecaster do
  subject { described_class }

  describe '.get_forecast' do
    let(:address) { '1600 Amphitheatre Parkway, Mountain View, CA' }

    it 'returns the weather' do
      expect(subject.get_forecast(address)).to eq(90)
    end
  end
end
