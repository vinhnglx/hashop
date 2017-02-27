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

  describe "#current_page" do
    it "returns current page" do
      product_service_page = ProductService.new(Product.includes(:category), {page: { number: 2, size: 1 }})

      expect(product_service_page.current_page).to eq 2
    end
  end

  describe "#page_size" do
    it "returns page size" do
      product_service_page = ProductService.new(Product.includes(:category), {page: { number: 2, size: 1 }})

      expect(product_service_page.page_size).to eq 1
    end
  end
end
