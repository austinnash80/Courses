class CreatePostcardRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :postcard_records do |t|
      t.string :company
      t.string :group
      t.string :mailing_id
      t.date :mail_date
      t.string :card
      t.integer :sent

      t.timestamps
    end
  end
end
