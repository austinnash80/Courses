json.extract! postcard_record, :id, :company, :group, :mailing_id, :mail_date, :card, :sent, :created_at, :updated_at
json.url postcard_record_url(postcard_record, format: :json)
