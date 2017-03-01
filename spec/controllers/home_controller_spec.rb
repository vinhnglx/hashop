require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  it "returns list of apis" do
    get :index

    jdata = JSON.parse(response.body)
    expect(response).to have_http_status(:ok)
    expect(jdata["products_url"]).to eq "/api/v1/products?{sort,page[number],page[size],filter[price][lt],filter[price][gt],filter[categories]}"
    expect(jdata["product_url"]).to eq "/api/v1/products/{id}"
  end
end
