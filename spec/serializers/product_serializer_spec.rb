require 'rails_helper'

RSpec.describe ProductSerializer do
  let!(:product) { create(:product) }
  let!(:serializer) { ProductSerializer.new(product) }
  let!(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }

  subject { JSON.parse(serialization.to_json) }

  it "should response expected Product attributes" do
    jdata = subject['data']['attributes']
    product_attributes = ['name', 'price', 'salePrice', 'underSale', 'soldOut']
    product_attributes.each do |i|
      expect(jdata.key?(i)).to be_truthy
    end
  end

  it "should response GET single product API Endpoint" do
    links = subject['data']['links']
    expect(links['self']).to eq "/api/v1/products/#{product.id}"
  end
end
