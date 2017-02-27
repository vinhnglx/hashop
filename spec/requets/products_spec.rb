require 'rails_helper'

RSpec.describe "Request: Products APIs", type: :request do
  context 'get all products' do
    it "returns http status success" do
      get '/api/v1/products'
      expect(response.content_type).to eq 'application/vnd.api+json'
      expect(response).to have_http_status(:success)
    end
  end

  context 'get single product' do
    describe 'with valid data' do
      let!(:product) { create(:product) }

      it "returns http status success" do
        get "/api/v1/products/#{product.id}"

        expect(response.content_type).to eq 'application/vnd.api+json'
        expect(response).to have_http_status(:success)
      end
    end

    describe 'with invalid data' do
      it "returns http status not found" do
        get '/api/v1/products/2347283290'

        expect(response.content_type).to eq 'application/vnd.api+json'
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
