class AddMsiInvoiceToMailings < ActiveRecord::Migration[5.1]
  def self.up
      add_attachment :mailings, :msi_invoice
    end

  def self.down
    remove_attachment :mailings, :msi_invoice
  end
end
