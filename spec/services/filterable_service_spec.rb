require 'rails_helper'

RSpec.describe FilterableService do
  let!(:category) { create(:category) }

  let!(:filter_without_params) { FilterableService.new }
  let!(:filter_without_categories) { FilterableService.new({filter: {price: 3}}) }
  let!(:filter_without_price) { FilterableService.new({filter: {categories: category.name}}) }

  before do
    5.times.each {|i| create(:product, price: i+1, category: category) }
  end

  describe "#price_parameter" do
    it "returns price number" do
      expect(filter_without_categories.price_parameter).to eq 3

      expect(filter_without_price.price_parameter).to be_nil
      expect(filter_without_params.price_parameter).to be_nil
    end
  end

  describe "#categories_parameter" do
    it "returns categories name" do
      expect(filter_without_params.categories_parameter).to be_nil
      expect(filter_without_categories.categories_parameter).to be_nil

      expect(filter_without_price.categories_parameter).to eq category.name
    end
  end

  describe "#category_ids" do
    it "returns array of category ids" do
      expect(filter_without_params.category_ids).to be_nil
      expect(filter_without_categories.category_ids).to be_nil

      expect(filter_without_price.category_ids).to eq [category.id]
    end
  end

  describe "#filter_params" do
    it "returns query objects" do
      expect(filter_without_params.filter_params).to eq({})
      expect(filter_without_categories.filter_params).to be_a Arel::Nodes::LessThanOrEqual
      expect(filter_without_price.filter_params).to be_a Arel::Nodes::In
    end
  end
end
