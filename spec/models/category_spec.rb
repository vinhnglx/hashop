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
  subject { described_class.new }

  context 'attributes' do
    it 'is valid with valid attributes' do
      subject.name = 'Classess'
      expect(subject).to be_valid
    end
  end

  context 'associations' do
    it 'has many products' do
      association = described_class.reflect_on_association(:products)
      expect(association.macro).to eq :has_many
    end
  end

  context 'validations' do
    it 'is invalid without name' do
      expect(subject).to be_invalid
    end
  end
end
