json.extract! postcard_return, :id, :company, :postmark, :postcard, :uid, :reason, :created_at, :updated_at
json.url postcard_return_url(postcard_return, format: :json)
