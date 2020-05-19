class AddExpDateToEmpireRcState < ActiveRecord::Migration[5.1]
  def change
    add_column :empire_rc_states, :exp_date, :date
  end
end
