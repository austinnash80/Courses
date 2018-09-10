json.extract! task, :id, :title, :note, :due, :due_date, :done, :important, :type_one, :type_two, :type_three, :extra_boolean, :extra_string, :extra_integer, :user_id, :doc, :created_at, :updated_at
json.url task_url(task, format: :json)
