class CreateMasterEas < ActiveRecord::Migration[5.1]
  def change
    create_table :master_eas do |t|
      t.integer :lid
      t.string :list
      t.string :lic
      t.string :fname
      t.string :mi
      t.string :lname
      t.string :suf
      t.string :co
      t.string :add2
      t.string :add
      t.string :city
      t.string :st
      t.string :zip
      t.integer :uid
      t.boolean :no_mail
      t.date :no_mail_date

      t.timestamps
    end
  end
end
