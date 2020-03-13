class AddEmpireCustomerIdToPostcardExports < ActiveRecord::Migration[5.1]
  def change
    add_column :postcard_exports, :empire_customer_id, :integer
  end
end
