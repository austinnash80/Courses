class AddSendEmailToPostcardExport < ActiveRecord::Migration[5.1]
  def change
    add_column :postcard_exports, :send_email, :string
  end
end
