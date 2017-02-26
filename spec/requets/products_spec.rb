require 'rails_helper'

RSpec.describe "Products APIs Requests", type: :request do
  it "get all products" do
    get '/api/v1/products'
    expect(response.content_type).to eq 'application/vnd.api+json'
    expect(response).to have_http_status(:success)
  end
end
