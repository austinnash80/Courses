json.extract! datasheet, :id, :seq_number, :seq_version, :category, :seq_title, :hours, :pub_date, :seq_update, :seq_original_list, :active, :drop_date, :drop_reason, :pes_number, :pes_version, :pes_listed, :needs_approval, :has_approval, :approval_info, :course_note, :extra_note, :extra_boolean, :extra_integer, :created_at, :updated_at
json.url datasheet_url(datasheet, format: :json)
