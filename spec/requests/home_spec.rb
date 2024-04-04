require 'rails_helper'

RSpec.describe "Homes", type: :request do
  before do
    allow(Forecaster).to receive(:call)
  end

  describe "GET /index" do
    it "returns page with expectd markup" do
      get "/"
      expect(response).to have_http_status(:success)
      expect(response.body).to include('TS Weather Forcaster')
    end

    it "returns empty json object for json call" do
      get "/", as: :json
      expect(response).to have_http_status(:success)
      expect(response.body).to eq('{}')
    end

    context "with invalid location" do
      it "returns error message" do
        allow(Forecaster).to receive(:call).and_raise(ForecasterError.new 'Invalid location')
        get "/?address=qwrasdfxadf"
        expect(response).to have_http_status(:success)
        expect(response.body).to include('Invalid location')
      end
    end
  end

end
