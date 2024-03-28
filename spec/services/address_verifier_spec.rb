require 'rails_helper'

RSpec.describe AddressVerifier do
  subject { described_class }

  describe '.valid?' do
    let(:address) { '1600 Amphitheatre Parkway, Mountain View, CA' }

    it 'returns true when address is found' do
      expect(subject.valid?(address)).to be
    end

    it 'returns false when address is not found' do
      expect(subject.valid?('this does note exist')).not_to be
    end
  end
end
