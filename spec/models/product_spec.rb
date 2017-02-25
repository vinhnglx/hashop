require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'attributes' do
    it 'is valid with valid attributes' do
      expect(Product.new).to be_valid
    end
  end

  context 'indexes' do
    it 'has an index on category_id'
  end

  context 'validates' do
    it 'is invalid without product name' do

    end

    it 'is invalid wihout price'

    it 'is invalid without category'
  end
end

