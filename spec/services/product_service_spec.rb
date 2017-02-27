require 'rails_helper'

RSpec.describe ProductService do
  let!(:product) { create(:product) }

  describe "#sort_params" do
    it "returns a hash contains sorting's way" do
      product_service_asc = ProductService.new(Product.includes(:category), {sort: 'price'})
      expect(product_service_asc.sort_params).to eq({"price"=>:asc})

      product_service_desc = ProductService.new(Product.includes(:category), {sort: '-price'})
      expect(product_service_desc.sort_params).to eq({"price"=>:desc})
    end
  end
end
