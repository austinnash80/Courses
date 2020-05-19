class CreateEmpireRcStates < ActiveRecord::Migration[5.1]
  def change
    create_table :empire_rc_states do |t|
      t.string :state
      t.string :exp_type
      t.string :master_list_name
      t.integer :master_list_quantity
      t.date :master_list_update_date
      t.date :master_list_update_next
      t.text :list_notes

      t.timestamps
    end
  end
end
