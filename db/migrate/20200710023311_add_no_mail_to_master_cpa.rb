class AddNoMailToMasterCpa < ActiveRecord::Migration[5.1]
  def change
    add_column :master_cpas, :no_mail, :boolean
    add_column :master_cpas, :no_mail_date, :date
  end
end
