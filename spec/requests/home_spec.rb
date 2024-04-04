# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  include_context 'shared network context'

  describe 'GET /index' do
    it 'returns page with expectd markup without a query' do
      get '/'
      expect(response).to have_http_status(:success)
      expect(response.body).to include('TS Weather Forcaster')
    end

    it 'returns page with expectd markup with a query' do
      get '/?address=Washington,DC'
      expect(response).to have_http_status(:success)
      expect(response.body).to include('TS Weather Forcaster')
      expect(response.body).to include('Today\'s forecast - Wednesday, 04/03/24')
    end

    context 'when there are errors' do
      it 'returns location error message for bad qeuries' do
        allow(Forecaster).to receive(:call).and_raise(ForecasterError.new('Invalid location'))
        get '/?address=qwrasdfxadf'
        expect(response).to have_http_status(:success)
        expect(response.body).to include('Invalid location')
        expect(response.body).to include('Please try again with a new request.')
      end

      it 'returns expected error message when a server error occurs' do
        allow(Forecaster).to receive(:call).and_raise(StandardError.new('Server error'))
        get '/?address=Washington,DC'
        expect(response).to have_http_status(:success)
        expect(response.body).to include('A server error occurred.')
        expect(response.body).to include('Please try again later.')
      end
    end
  end
end
