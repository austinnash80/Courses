class AddChangeToNoMail < ActiveRecord::Migration[5.1]
  def change
    add_column :seq_no_mails, :change, :boolean
    add_column :seq_no_mails, :lid, :integer
    add_column :seq_no_mails, :who, :string
    add_column :seq_no_mails, :list, :string
  end
end
