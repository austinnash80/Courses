class CreateMailingEmpireNms < ActiveRecord::Migration[5.1]
  def change
    create_table :mailing_empire_nms do |t|
      t.date :list
      t.string :license_type
      t.string :name_prefix
      t.string :first
      t.string :middle
      t.string :last
      t.string :license_no
      t.string :add1
      t.string :add2
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :county
      t.string :email
      t.string :licese_status
      t.date :issued
      t.date :expires
      t.date :last_renewal
      t.string :extra_s
      t.integer :extra_i
      t.boolean :extra_b
      t.date :extra_d

      t.timestamps
    end
  end
end
