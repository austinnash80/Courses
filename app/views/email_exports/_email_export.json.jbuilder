json.extract! email_export, :id, :empire_customer_id, :uid, :list, :license_number, :send_email, :company, :group, :send_date, :exp_b, :subject, :merge_1, :merge_2, :merge_3, :merge_4, :merge_5, :merge_6, :f_name, :l_name, :email, :created_at, :updated_at
json.url email_export_url(email_export, format: :json)
