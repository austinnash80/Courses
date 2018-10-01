class CreateInventories < ActiveRecord::Migration[5.1]
  def change
    create_table :inventories do |t|
      t.string :company
      t.string :version
      t.integer :number
      t.text :note
      t.string :extra_s
      t.integer :extra_i
      t.boolean :extra_b

      t.timestamps
    end
  end
end
