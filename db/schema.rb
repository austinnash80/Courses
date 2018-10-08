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

ActiveRecord::Schema.define(version: 20181008185159) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "copyrights", force: :cascade do |t|
    t.integer "seq_number"
    t.string "publisher"
    t.string "author"
    t.integer "cpdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "book"
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

  create_table "exams", force: :cascade do |t|
    t.integer "eid"
    t.integer "uid"
    t.string "des"
    t.date "start_date"
    t.date "complete_date"
    t.integer "seq_number"
    t.string "seq_v"
    t.string "seq_t"
    t.float "score"
    t.integer "rating"
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

  create_table "mail_items", force: :cascade do |t|
    t.integer "mail_id"
    t.string "title"
    t.integer "quantity"
    t.string "data_name"
    t.string "art_name"
    t.text "msi_note"
    t.text "note_1"
    t.text "note_2"
    t.boolean "complete"
    t.boolean "boolean_1"
    t.integer "integer_1"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "data_file_name"
    t.string "data_content_type"
    t.integer "data_file_size"
    t.datetime "data_updated_at"
  end

  create_table "mail_schedules", force: :cascade do |t|
    t.integer "mail_id"
    t.date "drop_date"
    t.integer "group_30"
    t.integer "group_60"
    t.integer "group_90"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mailing_postcards", force: :cascade do |t|
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

  create_table "notes", force: :cascade do |t|
    t.string "title"
    t.text "note"
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
    t.string "doc_file_name"
    t.string "doc_content_type"
    t.integer "doc_file_size"
    t.datetime "doc_updated_at"
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

  create_table "texas_royalties", force: :cascade do |t|
    t.string "quarter"
    t.integer "sold"
    t.decimal "cost"
    t.decimal "percentage"
    t.boolean "sent"
    t.integer "extra_i"
    t.boolean "extra_b"
    t.string "extra_s"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
