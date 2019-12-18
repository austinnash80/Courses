class CreateEmpireMasterLists < ActiveRecord::Migration[5.1]
  def change
    create_table :empire_master_lists do |t|
      t.integer :lid
      t.string :source
      t.string :list
      t.string :license_number
      t.string :record_type
      t.string :lic_status
      t.string :iss_date_s
      t.date :iss_date
      t.string :exp_date_s
      t.date :expe_date
      t.string :first_name
      t.string :mi
      t.string :last_name
      t.string :company
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :county
      t.date :extra_d
      t.string :extra_s
      t.boolean :extra_b

      t.timestamps
    end
  end
end
