class CreatePostcardMailings < ActiveRecord::Migration[5.1]
  def change
    create_table :postcard_mailings do |t|
      t.string :company
      t.string :version
      t.boolean :sent
      t.date :date_sent
      t.integer :number_sent
      t.text :note
      t.integer :extra_i
      t.boolean :extra_b
      t.string :extra_s

      t.timestamps
    end
  end
end
