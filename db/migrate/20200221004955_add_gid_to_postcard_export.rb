class AddGidToPostcardExport < ActiveRecord::Migration[5.1]
  def change
    add_column :postcard_exports, :g_id, :string
    add_column :postcard_exports, :extra_s, :string
    add_column :postcard_exports, :extra_i, :integer
    add_column :postcard_exports, :extra_b, :boolean
  end
end
