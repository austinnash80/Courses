class CreateEmailExports < ActiveRecord::Migration[5.1]
  def change
    create_table :email_exports do |t|
      t.integer :empire_customer_id
      t.integer :uid
      t.string :list
      t.string :license_number
      t.string :send_email
      t.string :company
      t.string :group
      t.date :send_date
      t.date :exp_b
      t.string :subject
      t.string :merge_1
      t.string :merge_2
      t.string :merge_3
      t.string :merge_4
      t.string :merge_5
      t.string :merge_6
      t.string :f_name
      t.string :l_name
      t.string :email

      t.timestamps
    end
  end
end
