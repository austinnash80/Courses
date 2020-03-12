class AddSendDateSToPostcardExport < ActiveRecord::Migration[5.1]
  def change
    add_column :postcard_exports, :send_date_s, :string
  end
end
