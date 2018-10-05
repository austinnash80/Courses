class AddEstimateToMailings < ActiveRecord::Migration[5.1]
  def change
    add_column :mailings, :estimate_quanity, :integer
    add_column :mailings, :estimate_cost, :decimal
  end
end
