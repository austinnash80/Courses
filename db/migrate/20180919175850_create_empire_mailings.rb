class CreateEmpireMailings < ActiveRecord::Migration[5.1]
  def change
    create_table :empire_mailings do |t|
      t.string :name
      t.date :drop
      t.date :date_extra
      t.string :state
      t.string :what
      t.integer :quanity_est
      t.integer :quanity_sent
      t.string :group_1
      t.string :group_2
      t.string :group_3
      t.string :data_name
      t.string :art_name
      t.text :msi_note
      t.text :note_1
      t.text :note_2
      t.boolean :complete
      t.boolean :boolean_1
      t.integer :integer_extra
      t.decimal :cost_service
      t.decimal :cost_print
      t.decimal :cost_postage

      t.timestamps
    end
  end
end
