# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  name       :string
#  price      :integer
#  sale_price :integer
#  under_sale :boolean          default(FALSE)
#  sold_out   :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Product < ApplicationRecord

  # Validations
  validates :name, :price, presence: true
end
