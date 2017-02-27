require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  context "GET index" do
    before do
      2.times.each { create(:category) }
      5.times.each { |n| create(:product, category: Category.all.sample, name: "Product #{n}", price: n) }
    end

    describe "returns all products" do
      it "returns with JSON body containing all products" do
        get :index
        jdata = JSON.parse response.body
        expect(jdata['data'].length).to eq 5
      end

      context "returns sorted products based on price" do
        it "with asc: [sort]='price' " do
          get :index, params: { sort: 'price' }
          jdata = JSON.parse response.body
          asc_prices = jdata['data'].map { |x| x['attributes']['price'] }
          expect(asc_prices).to eq [0, 1, 2, 3, 4]
        end

        it "with desc: [sort]='-price'" do
          get :index, params: { sort: '-price' }
          jdata = JSON.parse response.body
          desc_prices = jdata['data'].map { |x| x['attributes']['price'] }
          expect(desc_prices).to eq [4, 3, 2, 1, 0]
        end
      end

      context "paginations" do
        it "returns paginated products" do
          get :index, params: { page: { number: 2, size: 1 } }

          jdata = JSON.parse response.body
          expect(URI.unescape(jdata['links']['self'])).to eq "http://test.host/api/v1/products?page[number]=2&page[size]=1"
          expect(URI.unescape(jdata['links']['first'])).to eq "http://test.host/api/v1/products?page[number]=1&page[size]=1"
          expect(URI.unescape(jdata['links']['prev'])).to eq "http://test.host/api/v1/products?page[number]=1&page[size]=1"
          expect(URI.unescape(jdata['links']['next'])).to eq "http://test.host/api/v1/products?page[number]=3&page[size]=1"
          expect(URI.unescape(jdata['links']['last'])).to eq "http://test.host/api/v1/products?page[number]=5&page[size]=1"
        end
      end
    end
  end

  context "GET show" do
    describe "with valid data" do
      let(:product) { create(:product) }

      before do
        get :show, params: { id: product.id }
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

    describe "with invalid data" do
      before do
        get :show, params: { id: '930a' }
      end

      it "returns http status code: not found" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns JSON:API error block" do
        jdata = JSON.parse response.body
        expect(jdata['errors'][0]['detail']).to eq 'Wrong ID provided'
      end
    end
  end
end
