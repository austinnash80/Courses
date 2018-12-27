class AddRemoveToSeqNoMails < ActiveRecord::Migration[5.1]
  def change
    add_column :seq_no_mails, :remove, :boolean
  end
end
