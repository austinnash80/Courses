json.extract! email_campaign, :id, :company, :campaign_name, :delivery_service, :list_name, :segment, :segment_range, :segment_note, :start_date, :end_date, :active, :inactive, :tagline, :emails_sent, :delivered, :opened, :clicked, :blocked, :bounce, :spam, :extra_s, :extra_b, :extra_i, :created_at, :updated_at
json.url email_campaign_url(email_campaign, format: :json)
