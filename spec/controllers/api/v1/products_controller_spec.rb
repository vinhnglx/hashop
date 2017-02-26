require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
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

    it "returns with JSON body containing all products" do
      jdata = JSON.parse response.body
      expect(jdata['data'].length).to eq 5
    end
  end

  describe "GET single product" do
    context "with valid data" do
      let(:product) { Product.first }

      before do
        get :show, params: {id: product.id}
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns with JSON body containing specific product" do
        jdata = JSON.parse response.body
        j_product = jdata['data']['attributes']
        expect(j_product['name']).to eq product.name
        expect(j_product['price']).to eq product.price
        expect(j_product['salePrice']).to eq product.sale_price
        expect(j_product['underSale']).to eq product.under_sale
        expect(j_product['soldOut']).to eq product.sold_out
      end
    end

    context "with invalid data" do
    end
  end
end
