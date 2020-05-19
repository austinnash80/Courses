class AddFieldsToEmpireRcStates < ActiveRecord::Migration[5.1]
  def change
    add_column :empire_rc_states, :customers, :integer
    add_column :empire_rc_states, :matched_customers, :integer
  end
end
