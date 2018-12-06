json.extract! course_comment, :id, :taken, :course_number, :course_version, :comment_type, :comment_type_other, :comment_details, :comment_date, :extra_s, :extra_i, :extra_b, :extra_d, :created_at, :updated_at
json.url course_comment_url(course_comment, format: :json)
