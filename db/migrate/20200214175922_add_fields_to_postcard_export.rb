class AddFieldsToPostcardExport < ActiveRecord::Migration[5.1]
  def change
    add_column :postcard_exports, :exp, :date
    add_column :postcard_exports, :subject, :string
    add_column :postcard_exports, :merge_4, :string
    add_column :postcard_exports, :merge_5, :string
  end
end
