require 'rails_helper'

RSpec.describe WeatherDay do
  let(:payload) do
    {

    }
  end
  subject { described_class.new(payload) }

  it { expect(1).to eql(1) }
end
