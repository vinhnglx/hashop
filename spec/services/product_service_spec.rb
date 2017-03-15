require 'rails_helper'

RSpec.describe ProductService do
  describe "#products" do
    describe 'Sort by default' do
      before do
        @category = create(:category, name: "sample")

        Product.create!(name: "product 1", sale_price: 30, under_sale: true, price: 35, category: Category.all.sample)
        Product.create!(name: "product 2", sale_price: 26, under_sale: true, price: 40, category: Category.all.sample)
        Product.create!(name: "product 3", sale_price: 20, under_sale: false, price: 38, category: Category.all.sample)
        Product.create!(name: "product 4", sale_price: 23, under_sale: true, price: 41, category: Category.all.sample)
        Product.create!(name: "product 5", sale_price: 19, under_sale: false, price: 28, category: Category.all.sample)
      end

      it "returns a list has been sorted by under_sale value" do
        product_service = ProductService.new(
                            Product.includes(:category),
                            PaginatorService.new(number: 2, size: 1),
                            SortableService.new(sort: {}),
                            FilterableService.new
                          )

        expect(product_service.products.pluck(:name)).to eq ['product 4', 'product 2', 'product 5', 'product 1', 'product 3']
      end
    end

    describe 'Sort by any fields' do
      before do
        @category = create(:category, name: "sample")
        5.times.each { |n| create(:product, category: @category, name: "Product #{n}", price: n) }
      end

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
end
