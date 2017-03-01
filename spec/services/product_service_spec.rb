require 'rails_helper'

RSpec.describe ProductService do
  before do
    @category = create(:category, name: "sample")
    5.times.each { |n| create(:product, category: @category, name: "Product #{n}", price: n) }
  end

  describe "#products" do
    it "Returns a list has been sorted, paging and filtering by type if needed" do
      product_service = ProductService.new(
                          Product.includes(:category),
                          PaginatorService.new(number: 2, size: 1),
                          SortableService.new(sort: 'price'),
                          FilterableService.new
                        )

      expect(product_service.products.pluck(:price)).to eq [0, 1, 2, 3, 4]

      product_service_desc = ProductService.new(
                          Product.includes(:category),
                          PaginatorService.new(number: 2, size: 1),
                          SortableService.new(sort: '-price'),
                          FilterableService.new
                        )

      expect(product_service_desc.products.pluck(:price)).to eq [4, 3, 2, 1, 0]

      product_service_filter_price = ProductService.new(
                          Product.includes(:category),
                          PaginatorService.new(number: 2, size: 1),
                          SortableService.new(sort: '-price'),
                          FilterableService.new(filter: { price: { lt: 3, gt: 0 } })
                        )

      expect(product_service_filter_price.products.pluck(:price)).to eq [3, 2, 1, 0]

      product_service_filter_category = ProductService.new(
                          Product.includes(:category),
                          PaginatorService.new(number: 2, size: 1),
                          SortableService.new(sort: '-price'),
                          FilterableService.new(filter: { categories: 'sample' })
                        )

      expect(product_service_filter_category.products.pluck(:category_id).uniq).to eq [@category.id]
    end
  end
end
