json.extract! postcard_mailing, :id, :company, :version, :sent, :date_sent, :number_sent, :note, :extra_i, :extra_b, :extra_s, :created_at, :updated_at
json.url postcard_mailing_url(postcard_mailing, format: :json)
