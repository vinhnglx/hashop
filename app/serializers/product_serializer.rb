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

class ProductSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :price, :sale_price, :under_sale, :sold_out
  link(:self) { api_v1_product_path(object) }

  belongs_to :category
end
