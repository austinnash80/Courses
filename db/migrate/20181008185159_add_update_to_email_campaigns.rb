class AddUpdateToEmailCampaigns < ActiveRecord::Migration[5.1]
  def change
    add_column :email_campaigns, :update_stats, :date
  end
end
