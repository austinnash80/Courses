class AddFieldsToMailingEmpireNm < ActiveRecord::Migration[5.1]
  def change
    add_column :mailing_empire_nms, :customer, :boolean
    add_column :mailing_empire_nms, :no_mail, :boolean
    add_column :mailing_empire_nms, :dup, :string
    add_column :mailing_empire_nms, :dup_number, :integer
  end
end
