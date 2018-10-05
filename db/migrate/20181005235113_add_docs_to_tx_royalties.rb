class AddDocsToTxRoyalties < ActiveRecord::Migration[5.1]
  def self.up
    add_attachment :tx_royalties, :sales_report
  end

  def self.down
    remove_attachment :tx_royalties, :sales_report
  end
end
