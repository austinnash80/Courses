class AddOrderCostToInventories < ActiveRecord::Migration[5.1]
  def change
    add_column :inventories, :order, :date
    add_column :inventories, :cost, :decimal
  end
end
