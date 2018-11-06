json.extract! call_log, :id, :company, :caller_des, :caller_state, :customer, :caller_fname, :caller_lname, :UID, :call_length, :question_topic, :question_1, :question_2, :answered, :question_answer, :question_difficulty, :caller_satisfaction, :extra_b, :extra_i, :extra_s, :created_at, :updated_at
json.url call_log_url(call_log, format: :json)
