# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  price       :integer
#  sale_price  :integer
#  under_sale  :boolean          default(FALSE)
#  sold_out    :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#

require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'attributes' do
    it 'is valid with valid attributes' do
      product = build(:product)
      expect(product).to be_valid
    end
  end

  context 'indexes' do
    it 'has an index on category_id' do
      expect(ActiveRecord::Base.connection.index_exists?(:products, :category_id)).to be_truthy
    end
  end

  context 'validations' do
    let(:product) { build(:product) }
    it 'is invalid without product name' do
      product.name = nil
      expect(product).to be_invalid
    end

    it 'is invalid without price' do
      product.price = nil
      expect(product).to be_invalid
    end
  end

  context 'associations' do
    it "belongs to category" do
      association = Product.reflect_on_association(:category)
      expect(association.macro).to eq :belongs_to
    end
  end
end
