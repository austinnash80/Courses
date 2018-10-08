class CreateEmailCampaigns < ActiveRecord::Migration[5.1]
  def change
    create_table :email_campaigns do |t|
      t.string :company
      t.string :campaign_name
      t.string :delivery_service
      t.string :list_name
      t.string :segment
      t.string :segment_range
      t.string :segment_note
      t.date :start_date
      t.date :end_date
      t.boolean :active
      t.boolean :inactive
      t.string :tagline
      t.integer :emails_sent
      t.integer :delivered
      t.integer :opened
      t.integer :clicked
      t.integer :blocked
      t.integer :bounce
      t.integer :spam
      t.string :extra_s
      t.boolean :extra_b
      t.integer :extra_i

      t.timestamps
    end
  end
end
