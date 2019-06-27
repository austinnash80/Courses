json.extract! task_deadline, :id, :title, :state, :note, :status, :date_s, :date_f, :extra_s, :extra_i, :extra_b, :extra_d, :created_at, :updated_at
json.url task_deadline_url(task_deadline, format: :json)
