class AddReceiptToEmpireStateList < ActiveRecord::Migration[5.1]
  def self.up
      add_attachment :empire_state_lists, :receipt
    end

  def self.down
    remove_attachment :empire_state_lists, :receipt
  end
end
