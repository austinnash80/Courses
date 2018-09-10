class CreateMailings < ActiveRecord::Migration[5.1]
  def change
    create_table :mailings do |t|
      t.string :name
      t.date :drop
      t.date :date_extra
      t.string :who
      t.string :what
      t.integer :quantity_sent
      t.integer :group_1
      t.integer :group_2
      t.integer :group_3
      t.integer :group_4
      t.integer :group_5
      t.string :data_name
      t.string :art_name
      t.string :msi_note
      t.text :note_1
      t.text :note_2
      t.string :note_3
      t.boolean :complete
      t.boolean :boolean_1
      t.integer :integer_1
      t.decimal :cost_service
      t.decimal :cost_print
      t.decimal :cost_postage
      t.string :note_4

      t.timestamps
    end
  end
end
