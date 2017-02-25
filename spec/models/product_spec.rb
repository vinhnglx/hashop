# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  name       :string
#  price      :integer
#  sale_price :integer
#  under_sale :boolean
#  sold_out   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { described_class.new(name: "AQUA Contact Lens", price: 2450) }

  context 'attributes' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
  end

  context 'indexes' do
    it 'has an index on category_id'
  end

  context 'validates' do
    it 'is invalid without product name' do
      subject.name = nil
      expect(subject).to be_invalid
    end

    it 'is invalid without price' do
      subject.price = nil
      expect(subject).to be_invalid
    end

    it 'is invalid without category'
  end
end

