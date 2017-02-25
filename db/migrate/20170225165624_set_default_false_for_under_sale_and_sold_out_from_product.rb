class SetDefaultFalseForUnderSaleAndSoldOutFromProduct < ActiveRecord::Migration[5.1]
  def change
    change_column :products, :under_sale, :boolean, default: false
    change_column :products, :sold_out, :boolean, default: false
  end
end
