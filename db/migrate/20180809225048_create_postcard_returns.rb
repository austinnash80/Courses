class CreatePostcardReturns < ActiveRecord::Migration[5.1]
  def change
    create_table :postcard_returns do |t|
      t.string :company
      t.date :postmark
      t.string :postcard
      t.integer :uid
      t.string :reason

      t.timestamps
    end
  end
end
