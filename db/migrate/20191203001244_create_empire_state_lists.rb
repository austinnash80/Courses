class CreateEmpireStateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :empire_state_lists do |t|
      t.string :st
      t.string :tilte
      t.decimal :cost
      t.text :notes
      t.string :extra_s
      t.string :list_file_name
      t.string :list_content_type
      t.integer :list_file_size
      t.datetime :list_updated_at

      t.timestamps
    end
  end
end
