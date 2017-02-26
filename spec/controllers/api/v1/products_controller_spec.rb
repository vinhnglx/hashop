require 'rails_helper'

RSpec.describe API::V1::ProductsController, type: :controller do

  before do
    2.times.each { create(:category) }
    5.times.each { |n| create(:product, category: Category.all.sample, name: "Product #{n}") }
  end

  describe "GET multiple products" do
    before do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns content-type: application/vnd.api+json" do
      expect(response.content_type).to eq 'application/vnd.api+json'
    end

    it "respons with JSON body containing all products" do
      jdata = JSON.parse response.body
      expect(jdata['data'].length).to eq 5
    end
  end

end
