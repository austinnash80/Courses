json.extract! exam_result, :id, :week_s, :week_e, :course_number, :course_version, :course_title, :who, :score_avg, :rating, :taken, :exta_i, :extra_s, :extra_b, :created_at, :updated_at
json.url exam_result_url(exam_result, format: :json)
