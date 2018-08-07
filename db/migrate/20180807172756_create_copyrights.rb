class CreateCopyrights < ActiveRecord::Migration[5.1]
  def change
    create_table :copyrights do |t|
      t.integer :seq_number
      t.string :publisher
      t.string :author
      t.integer :cpdate

      t.timestamps
    end
  end
end
