require 'rails_helper'

RSpec.describe FilterableService do
  let!(:category) { create(:category) }

  let!(:filter_without_params) { FilterableService.new }
  let!(:filter_without_categories_lt) { FilterableService.new(filter: { price: { lt: 3 } }) }
  let!(:filter_without_categories_gt) { FilterableService.new(filter: { price: { gt: 1 } }) }
  let!(:filter_without_categories_lt_gt) { FilterableService.new(filter: { price: { gt: 1, lt: 3 } }) }
  let!(:filter_without_price) { FilterableService.new(filter: { categories: category.name }) }
  let!(:filter) { FilterableService.new(filter: { price: { lt: 1, gt: 4 }, categories: category.name }) }

  before do
    5.times.each { |i| create(:product, price: i + 1, category: category) }
  end

  describe "#price_parameter" do
    it "returns price number" do
      expect(filter_without_categories_lt.price_parameter).to eq(lt: 3)
      expect(filter_without_categories_gt.price_parameter).to eq(gt: 1)
      expect(filter_without_categories_lt_gt.price_parameter).to eq(gt: 1, lt: 3)

      expect(filter_without_price.price_parameter).to be_nil
      expect(filter_without_params.price_parameter).to be_nil
    end
  end

  describe "#query_price" do
    it "returns query for price" do
      expect(filter_without_categories_lt.query_price).to be_a Arel::Nodes::LessThanOrEqual
      expect(filter_without_categories_gt.query_price).to be_a Arel::Nodes::GreaterThanOrEqual
      expect(filter_without_categories_lt_gt.query_price).to be_a Arel::Nodes::And

      expect(filter_without_price.query_price).to be_nil
      expect(filter_without_params.query_price).to be_nil
    end
  end

  describe "#categories_parameter" do
    it "returns categories name" do
      expect(filter_without_params.categories_parameter).to be_nil

      expect(filter_without_categories_lt.categories_parameter).to be_nil
      expect(filter_without_categories_gt.categories_parameter).to be_nil
      expect(filter_without_categories_lt_gt.categories_parameter).to be_nil

      expect(filter_without_price.categories_parameter).to eq category.name
    end
  end

  describe "#category_ids" do
    it "returns array of category ids" do
      expect(filter_without_params.category_ids).to be_nil

      expect(filter_without_categories_lt.category_ids).to be_nil
      expect(filter_without_categories_gt.category_ids).to be_nil
      expect(filter_without_categories_lt_gt.category_ids).to be_nil

      expect(filter_without_price.category_ids).to eq [category.id]
    end
  end

  describe "#filter_params" do
    it "returns query objects" do
      expect(filter_without_params.filter_params).to eq({})

      expect(filter_without_categories_lt.filter_params).to be_a Arel::Nodes::LessThanOrEqual
      expect(filter_without_categories_gt.filter_params).to be_a Arel::Nodes::GreaterThanOrEqual
      expect(filter_without_categories_lt_gt.filter_params).to be_a Arel::Nodes::And

      expect(filter_without_price.filter_params).to be_a Arel::Nodes::In

      expect(filter.filter_params).to be_a Arel::Nodes::And
    end
  end
end
