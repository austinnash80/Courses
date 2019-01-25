json.extract! calendar, :id, :event_date, :title, :details, :people, :creator, :reoccurring, :reoccurring_rate, :tag, :extra_d, :extra_i, :extra_s, :created_at, :updated_at
json.url calendar_url(calendar, format: :json)
