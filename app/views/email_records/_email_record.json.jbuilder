json.extract! email_record, :id, :company, :group, :mailing_id, :mail_date, :sent, :created_at, :updated_at
json.url email_record_url(email_record, format: :json)
