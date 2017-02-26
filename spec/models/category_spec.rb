# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'attributes' do
    it 'is valid with valid attributes' do
      category = build(:category)
      expect(category).to be_valid
    end
  end

  context 'associations' do
    it 'has many products' do
      association = Category.reflect_on_association(:products)
      expect(association.macro).to eq :has_many
    end
  end

  context 'validations' do
    let(:category) { build(:category) }

    it 'is invalid without name' do
      category.name = nil
      expect(category).to be_invalid
    end

    it 'is invalid if categories has same name' do
      category_1 = create(:category, name: "Brush")

      category.name = "Brush"
      expect(subject).to be_invalid
    end
  end
end
