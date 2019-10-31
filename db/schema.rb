# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20191031210737) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calendars", force: :cascade do |t|
    t.date "event_date"
    t.string "title"
    t.text "details"
    t.string "people"
    t.string "creator"
    t.string "reoccurring"
    t.string "reoccurring_rate"
    t.string "tag"
    t.date "extra_d"
    t.integer "extra_i"
    t.string "extra_s"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "call_logs", force: :cascade do |t|
    t.string "company"
    t.string "caller_des"
    t.string "caller_state"
    t.boolean "customer"
    t.string "caller_fname"
    t.string "caller_lname"
    t.integer "UID"
    t.decimal "call_length"
    t.string "question_topic"
    t.text "question_1"
    t.text "question_2"
    t.boolean "answered"
    t.text "question_answer"
    t.integer "question_difficulty"
    t.integer "caller_satisfaction"
    t.boolean "extra_b"
    t.integer "extra_i"
    t.string "extra_s"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "taken"
    t.date "call_date"
    t.text "note"
    t.string "question_1_topic_other"
    t.string "question_2_topic"
    t.string "question_2_topic_other"
    t.text "question_1_other"
    t.text "question_2_other"
    t.boolean "question_2_answered"
    t.text "question_2_answer"
    t.text "question_additional"
    t.text "question_additional_answer"
    t.integer "question_satisfaction"
    t.integer "call_difficulty"
    t.time "call_time"
  end

  create_table "copyrights", force: :cascade do |t|
    t.integer "seq_number"
    t.string "publisher"
    t.string "author"
    t.integer "cpdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "book"
  end

  create_table "course_comments", force: :cascade do |t|
    t.string "taken"
    t.integer "course_number"
    t.string "course_version"
    t.string "comment_type"
    t.string "comment_type_other"
    t.text "comment_details"
    t.date "comment_date"
    t.string "extra_s"
    t.integer "extra_i"
    t.boolean "extra_b"
    t.date "extra_d"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_creation_tasks", force: :cascade do |t|
    t.integer "empire_course_id"
    t.string "task"
    t.text "task_note_1"
    t.text "task_note_2"
    t.text "task_note_3"
    t.string "assign_1"
    t.string "assign_2"
    t.string "assign_3"
    t.string "extra_s"
    t.text "extra_t"
    t.integer "extra_i"
    t.date "extra_d"
    t.boolean "extra_b"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "course_creation_templete_id"
  end

  create_table "course_creation_templetes", force: :cascade do |t|
    t.string "templete_type"
    t.text "instruction_1"
    t.text "instruction_2"
    t.string "extra_s"
    t.text "extra_t"
    t.integer "extra_i"
    t.date "extra_d"
    t.boolean "extra_b"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "time_multiple"
  end

  create_table "cpe_due_dates", force: :cascade do |t|
    t.string "state"
    t.integer "quanity"
    t.string "cpe_group"
    t.string "renew_type"
    t.string "cpe_due"
    t.integer "ss_allowed"
    t.integer "year_minimum"
    t.boolean "exclude"
    t.string "extra_s"
    t.boolean "extra_b"
    t.integer "extra_i"
    t.date "extra_d"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "st"
    t.text "state_note"
    t.string "partial_mail"
    t.decimal "partial_number"
  end

  create_table "datasheets", force: :cascade do |t|
    t.integer "seq_number"
    t.string "seq_version"
    t.string "category"
    t.string "seq_title"
    t.integer "hours"
    t.date "pub_date"
    t.date "seq_update"
    t.date "seq_original_list"
    t.boolean "active"
    t.date "drop_date"
    t.text "drop_reason"
    t.integer "pes_number"
    t.string "pes_version"
    t.boolean "pes_listed"
    t.boolean "needs_approval"
    t.boolean "has_approval"
    t.text "approval_info"
    t.text "course_note"
    t.text "extra_note"
    t.boolean "extra_boolean"
    t.integer "extra_integer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "version_0"
    t.date "version_a"
    t.date "version_b"
    t.date "version_c"
    t.date "version_d"
    t.date "version_e"
    t.date "version_f"
    t.date "version_g"
    t.date "version_h"
    t.date "version_i"
    t.date "version_j"
    t.date "version_k"
    t.date "version_l"
    t.date "version_m"
    t.date "version_n"
  end

  create_table "date_fields", force: :cascade do |t|
    t.date "date1"
    t.date "date2"
    t.date "date3"
    t.date "date4"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "email_campaigns", force: :cascade do |t|
    t.string "company"
    t.string "campaign_name"
    t.string "delivery_service"
    t.string "list_name"
    t.string "segment"
    t.string "segment_range"
    t.string "segment_note"
    t.date "start_date"
    t.date "end_date"
    t.boolean "active"
    t.boolean "inactive"
    t.string "tagline"
    t.integer "emails_sent"
    t.integer "delivered"
    t.integer "opened"
    t.integer "clicked"
    t.integer "blocked"
    t.integer "bounce"
    t.integer "spam"
    t.string "extra_s"
    t.boolean "extra_b"
    t.integer "extra_i"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "update_stats"
  end

  create_table "empire_courses", force: :cascade do |t|
    t.integer "number"
    t.string "version"
    t.string "title"
    t.string "category"
    t.integer "hours"
    t.string "extra_s"
    t.integer "extra_i"
    t.date "extra_d"
    t.boolean "extra_b"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "empire_customers", force: :cascade do |t|
    t.string "uid"
    t.string "license_num"
    t.string "existing"
    t.string "purchase_date"
    t.string "lic_state"
    t.string "products"
    t.string "order_total"
    t.string "fname"
    t.string "lname"
    t.string "company"
    t.string "street_1"
    t.string "street_2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ids"
    t.integer "e_id"
    t.date "p_date"
    t.decimal "total"
  end

  create_table "empire_mailings", force: :cascade do |t|
    t.string "name"
    t.date "drop"
    t.date "date_extra"
    t.string "state"
    t.string "what"
    t.integer "quanity_est"
    t.integer "quanity_sent"
    t.string "group_1"
    t.string "group_2"
    t.string "group_3"
    t.string "data_name"
    t.string "art_name"
    t.text "msi_note"
    t.text "note_1"
    t.text "note_2"
    t.boolean "complete"
    t.boolean "boolean_1"
    t.integer "integer_extra"
    t.decimal "cost_service"
    t.decimal "cost_print"
    t.decimal "cost_postage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exam_results", force: :cascade do |t|
    t.date "week_s"
    t.date "week_e"
    t.integer "course_number"
    t.string "course_version"
    t.string "course_title"
    t.string "who"
    t.decimal "score_avg"
    t.decimal "rating"
    t.integer "taken"
    t.integer "exta_i"
    t.string "extra_s"
    t.boolean "extra_b"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventories", force: :cascade do |t|
    t.string "company"
    t.string "version"
    t.integer "number"
    t.text "note"
    t.string "extra_s"
    t.integer "extra_i"
    t.boolean "extra_b"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "order"
    t.decimal "cost"
  end

  create_table "live_chat_answers", force: :cascade do |t|
    t.string "company"
    t.string "state"
    t.string "des"
    t.string "question"
    t.string "topic"
    t.text "answer"
    t.text "notes"
    t.date "date_org"
    t.integer "extra_i"
    t.integer "extra_s"
    t.date "extra_d"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "policy"
  end

  create_table "mailing_empire_nms", force: :cascade do |t|
    t.date "list"
    t.string "license_type"
    t.string "name_prefix"
    t.string "first"
    t.string "middle"
    t.string "last"
    t.string "license_no"
    t.string "add1"
    t.string "add2"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "county"
    t.string "email"
    t.string "licese_status"
    t.date "issued"
    t.date "expires"
    t.date "last_renewal"
    t.string "extra_s"
    t.integer "extra_i"
    t.boolean "extra_b"
    t.date "extra_d"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "customer"
    t.boolean "no_mail"
    t.string "dup"
    t.integer "dup_number"
  end

  create_table "mailings", force: :cascade do |t|
    t.string "name"
    t.date "drop"
    t.date "date_extra"
    t.string "who"
    t.string "what"
    t.integer "quantity_sent"
    t.integer "group_1"
    t.integer "group_2"
    t.integer "group_3"
    t.integer "group_4"
    t.integer "group_5"
    t.string "data_name"
    t.string "art_name"
    t.string "msi_note"
    t.text "note_1"
    t.text "note_2"
    t.string "note_3"
    t.boolean "complete"
    t.boolean "boolean_1"
    t.integer "integer_1"
    t.decimal "cost_service"
    t.decimal "cost_print"
    t.decimal "cost_postage"
    t.string "note_4"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "msi_art_file_name"
    t.string "msi_art_content_type"
    t.integer "msi_art_file_size"
    t.datetime "msi_art_updated_at"
    t.string "msi_data_file_name"
    t.string "msi_data_content_type"
    t.integer "msi_data_file_size"
    t.datetime "msi_data_updated_at"
    t.string "msi_invoice_file_name"
    t.string "msi_invoice_content_type"
    t.integer "msi_invoice_file_size"
    t.datetime "msi_invoice_updated_at"
    t.string "people_report_file_name"
    t.string "people_report_content_type"
    t.integer "people_report_file_size"
    t.datetime "people_report_updated_at"
    t.integer "estimate_quanity"
    t.decimal "estimate_cost"
  end

  create_table "master_lists", force: :cascade do |t|
    t.string "who"
    t.string "list"
    t.integer "lid"
    t.string "lic"
    t.string "fname"
    t.string "mi"
    t.string "lname"
    t.string "suf"
    t.string "co"
    t.string "add2"
    t.string "add"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "no_mail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pes_courses", force: :cascade do |t|
    t.integer "pes_number"
    t.string "category"
    t.integer "hours"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "tag"
    t.date "date_added"
    t.date "date_removed"
    t.string "extra_s"
    t.integer "extra_i"
    t.boolean "extra_b"
    t.date "extra_d"
  end

  create_table "postcard_mailings", force: :cascade do |t|
    t.string "company"
    t.string "version"
    t.boolean "sent"
    t.date "date_sent"
    t.integer "number_sent"
    t.text "note"
    t.integer "extra_i"
    t.boolean "extra_b"
    t.string "extra_s"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "postcard_returns", force: :cascade do |t|
    t.string "company"
    t.date "postmark"
    t.string "postcard"
    t.integer "uid"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales", force: :cascade do |t|
    t.date "day"
    t.decimal "sequoia"
    t.decimal "empire"
    t.decimal "pacific"
    t.decimal "extra_d"
    t.string "extra_s"
    t.boolean "extra_b"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seq_customers", force: :cascade do |t|
    t.integer "order_id"
    t.integer "uid"
    t.date "purchase"
    t.string "product_1"
    t.string "product_2"
    t.string "designation"
    t.string "fname"
    t.string "lname"
    t.string "street_1"
    t.string "street_2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "email"
    t.integer "price_2"
    t.string "lic_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seq_no_mails", force: :cascade do |t|
    t.string "first_name"
    t.string "mi"
    t.string "last_name"
    t.string "suf"
    t.string "co"
    t.string "address"
    t.string "address_2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.date "date_added"
    t.integer "extra_i"
    t.boolean "extra_b"
    t.string "extra_s"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "remove"
    t.boolean "change"
    t.integer "lid"
    t.string "who"
    t.string "list"
  end

  create_table "sequoia_customers", force: :cascade do |t|
    t.integer "unique_id"
    t.integer "order_id"
    t.integer "uid"
    t.date "purchase_date"
    t.string "product"
    t.string "who"
    t.string "what"
    t.string "hours"
    t.integer "price"
    t.string "fname"
    t.string "lname"
    t.string "street_1"
    t.string "street_2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "email"
    t.string "lic_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sequoia_exams", force: :cascade do |t|
    t.integer "aid"
    t.integer "lid"
    t.integer "uid"
    t.string "who"
    t.date "date_s"
    t.date "date_c"
    t.integer "course_number"
    t.string "course_version"
    t.string "course_title"
    t.integer "score"
    t.integer "rate"
    t.integer "extra_i"
    t.string "extra_s"
    t.boolean "extra_b"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_deadlines", force: :cascade do |t|
    t.string "title"
    t.string "state"
    t.text "note"
    t.string "status"
    t.date "date_s"
    t.date "date_f"
    t.string "extra_s"
    t.integer "extra_i"
    t.boolean "extra_b"
    t.date "extra_d"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cost"
    t.integer "time"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.string "note"
    t.boolean "due"
    t.date "due_date"
    t.boolean "done"
    t.boolean "important"
    t.boolean "type_one"
    t.boolean "type_two"
    t.boolean "type_three"
    t.boolean "extra_boolean"
    t.string "extra_string"
    t.integer "extra_integer"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "update_note"
    t.string "user_1"
    t.string "user_2"
    t.string "user_3"
    t.string "user_4"
    t.string "user_5"
    t.string "user_6"
    t.string "user_7"
    t.text "additional_note_2"
    t.text "additional_note_3"
    t.boolean "no_due_date"
    t.string "task_doc_1_file_name"
    t.string "task_doc_1_content_type"
    t.integer "task_doc_1_file_size"
    t.datetime "task_doc_1_updated_at"
    t.string "task_doc_2_file_name"
    t.string "task_doc_2_content_type"
    t.integer "task_doc_2_file_size"
    t.datetime "task_doc_2_updated_at"
  end

  create_table "tx_royalties", force: :cascade do |t|
    t.string "quarter"
    t.date "start_date"
    t.date "end_date"
    t.date "sent_date"
    t.integer "sold"
    t.decimal "cost"
    t.decimal "percentage"
    t.boolean "sent"
    t.integer "extra_i"
    t.boolean "extra_b"
    t.string "extra_s"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sales_report_file_name"
    t.string "sales_report_content_type"
    t.integer "sales_report_file_size"
    t.datetime "sales_report_updated_at"
  end

  create_table "updatesheets", force: :cascade do |t|
    t.integer "pes_number"
    t.string "pes_version"
    t.date "date_received"
    t.boolean "update_course"
    t.text "note_approval"
    t.boolean "text_complete"
    t.boolean "exam_complete"
    t.boolean "course_listed"
    t.date "date_listed"
    t.string "role"
    t.string "rolep"
    t.string "irs_number"
    t.boolean "proofed"
    t.text "proofed_note"
    t.integer "datasheet_id"
    t.integer "seq_number"
    t.string "seq_version"
    t.string "seq_title"
    t.string "extra_string"
    t.integer "extra_integer"
    t.boolean "extra_boolean"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "pub_date"
    t.boolean "update_datasheet"
    t.date "extra_d"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.boolean "superadmin_role", default: false
    t.boolean "supervisor_role", default: false
    t.boolean "user_role", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
