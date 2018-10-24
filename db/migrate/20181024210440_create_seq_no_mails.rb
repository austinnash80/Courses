class CreateSeqNoMails < ActiveRecord::Migration[5.1]
  def change
    create_table :seq_no_mails do |t|
      t.string :first_name
      t.string :mi
      t.string :last_name
      t.string :suf
      t.string :co
      t.string :address
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip
      t.date :date_added
      t.integer :extra_i
      t.boolean :extra_b
      t.string :extra_s

      t.timestamps
    end
  end
end
