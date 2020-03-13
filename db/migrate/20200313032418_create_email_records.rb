class CreateEmailRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :email_records do |t|
      t.string :company
      t.string :group
      t.string :mailing_id
      t.date :mail_date
      t.integer :sent

      t.timestamps
    end
  end
end
