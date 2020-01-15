class CreatePostcardExports < ActiveRecord::Migration[5.1]
  def change
    create_table :postcard_exports do |t|
      t.string :company
      t.string :group
      t.string :mail_id
      t.date :mail_date
      t.string :state
      t.string :list
      t.string :license_number
      t.integer :uid
      t.string :merge_1
      t.string :merge_2
      t.string :merge_3
      t.string :f_name
      t.string :l_name
      t.string :add_1
      t.string :add_2
      t.string :city
      t.string :st
      t.string :zip
      t.string :email

      t.timestamps
    end
  end
end
