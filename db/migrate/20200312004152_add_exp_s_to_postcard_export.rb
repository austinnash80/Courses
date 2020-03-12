class AddExpSToPostcardExport < ActiveRecord::Migration[5.1]
  def change
    add_column :postcard_exports, :exp_s, :string
  end
end
