class AddBookToCopyrights < ActiveRecord::Migration[5.1]
  def change
    add_column :copyrights, :book, :string
  end
end
