# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_23_044954) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "absents", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.integer "location"
    t.integer "classtype_id"
    t.integer "level_id"
    t.date "date"
    t.time "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "reason", default: "N/A | Absent was submitted before 'Reason' was added to form."
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", id: :serial, force: :cascade do |t|
    t.integer "addressable_id"
    t.string "addressable_type"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "bff_dance_parties", id: :serial, force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.string "suggestion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "granite_bay_start_time"
    t.integer "granite_bay_duration"
    t.time "folsom_start_time"
    t.integer "folsom_duration"
    t.time "sacramento_start_time"
    t.integer "sacramento_duration"
    t.string "image"
  end

  create_table "bubble_contents", id: :serial, force: :cascade do |t|
    t.string "link"
    t.string "image"
    t.string "color"
    t.string "text"
    t.string "text_color"
    t.boolean "show_button"
    t.integer "sort_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "camps", id: :serial, force: :cascade do |t|
    t.string "title"
    t.date "registration_opens"
    t.date "registration_closes"
    t.string "image"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "classtypes", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coach_classtypes", id: :serial, force: :cascade do |t|
    t.integer "classtype_id"
    t.integer "coach_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coach_levels", id: :serial, force: :cascade do |t|
    t.integer "level_id"
    t.integer "coach_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coach_locations", id: :serial, force: :cascade do |t|
    t.integer "coach_id"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coaches", id: :serial, force: :cascade do |t|
    t.string "image", limit: 255
    t.string "firstname", limit: 255
    t.string "lastname", limit: 255
    t.string "gender", limit: 255
    t.date "birthdate"
    t.date "startdate"
    t.text "experience"
    t.string "fav_event", limit: 255
    t.string "fav_skill", limit: 255
    t.string "fav_food", limit: 255
    t.text "advice"
    t.string "disney_char", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "strengths", limit: 255
    t.boolean "current_employee", default: true
    t.string "tag_image"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.text "comment"
    t.string "name", limit: 255
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "activity", limit: 255
    t.string "email", limit: 255
  end

  create_table "discontinue_notices", id: :serial, force: :cascade do |t|
    t.string "reason", limit: 255
    t.string "student_first_name", limit: 255
    t.string "student_last_name", limit: 255
    t.integer "location"
    t.integer "class_day"
    t.time "class_time"
    t.date "last_day"
    t.string "parent_name", limit: 255
    t.boolean "understood"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employment_application_reviews", id: :serial, force: :cascade do |t|
    t.integer "status"
    t.text "notes"
    t.string "last_edited_by"
    t.integer "employment_application_id"
    t.string "location"
    t.string "department"
    t.boolean "archived"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "next_review_id"
    t.boolean "active", default: true
  end

  create_table "employment_applications", id: :serial, force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "middlename"
    t.string "image"
    t.string "resume"
    t.boolean "granite_bay"
    t.boolean "folsom"
    t.boolean "sacramento"
    t.boolean "gymnastics"
    t.boolean "dance"
    t.boolean "swim"
    t.boolean "tag"
    t.boolean "hospitality"
    t.string "phone"
    t.boolean "mornings"
    t.boolean "saturdays"
    t.text "previous_experience"
    t.text "experience_with_children"
    t.text "previous_office_experience"
    t.text "customer_service_experience"
    t.text "reason"
    t.string "email"
    t.string "position_desired"
    t.boolean "over_eighteen"
    t.boolean "can_drive"
    t.boolean "can_commit_one_year"
    t.string "expected_pay"
    t.integer "desired_hours"
    t.date "date_available"
    t.text "job_requirements_response"
    t.string "high_school_year"
    t.string "high_school_graduation_year"
    t.string "high_school_name"
    t.string "college_year"
    t.string "college_graduation_year"
    t.string "college_name"
    t.string "college_degree"
    t.text "hobbies"
    t.boolean "continuing_education"
    t.string "do_not_contact_employer"
    t.text "do_not_contact_reason"
    t.boolean "convicted"
    t.text "convictions"
    t.date "interview_date"
    t.string "interviewed_by"
    t.string "status"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "archived"
  end

  create_table "employment_histories", id: :serial, force: :cascade do |t|
    t.integer "history_id"
    t.string "history_type"
    t.string "company_name"
    t.string "supervisor_name"
    t.string "job_title"
    t.text "description"
    t.string "phone"
    t.date "start_date"
    t.date "end_date"
    t.text "reason_for_leaving"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["history_type", "history_id"], name: "index_employment_histories_on_history_type_and_history_id"
  end

  create_table "kid_quotes", id: :serial, force: :cascade do |t|
    t.text "quote"
    t.string "name", limit: 255
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kids_night_outs", id: :serial, force: :cascade do |t|
    t.string "title"
    t.date "date"
    t.text "details"
    t.time "sac_time"
    t.time "fol_time"
    t.time "gb_time"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "levels", id: :serial, force: :cascade do |t|
    t.string "levelname", limit: 255
    t.integer "length"
    t.string "age", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sort_order"
    t.integer "classtype_id"
    t.string "gender", limit: 255
    t.string "jack_rabbit_name", limit: 255
    t.string "color", limit: 255
    t.text "description"
    t.text "short_description"
    t.string "video_url", limit: 255
    t.string "image", limit: 255
    t.boolean "show_registration"
    t.boolean "active", default: true
  end

  create_table "locations", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "shortname"
  end

  create_table "making_a_differences", force: :cascade do |t|
    t.text "comment"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type_of_life"
  end

  create_table "parties", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "video"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.string "activities"
    t.integer "sort_order"
  end

  create_table "promo_slides", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.boolean "link", default: false
    t.boolean "live", default: false
    t.string "data_type", limit: 255, default: "Image"
    t.string "image", limit: 255
    t.text "html_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link_path", limit: 255
    t.integer "sort_order"
  end

  create_table "recital_ad_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "price"
    t.integer "word_max"
    t.string "actual_size", limit: 255
    t.boolean "image"
    t.boolean "pdf_file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recital_ads", id: :serial, force: :cascade do |t|
    t.string "firstname", limit: 255
    t.string "lastname", limit: 255
    t.string "email", limit: 255
    t.text "message"
    t.string "image", limit: 255
    t.string "pdf_file", limit: 255
    t.integer "recital_ad_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recital_sign_ups", id: :serial, force: :cascade do |t|
    t.string "child_first_name"
    t.string "child_last_name"
    t.integer "location"
    t.boolean "participating"
    t.integer "total_recitals"
    t.boolean "multiple_recitals"
    t.boolean "multiple_children"
    t.string "costume_fee_agreement"
    t.string "recital_fee_agreement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tricks_u_categories", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.integer "weight"
    t.boolean "hidden"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tricks_u_videos", id: :serial, force: :cascade do |t|
    t.string "url", limit: 255
    t.string "title", limit: 255
    t.integer "weight"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255
    t.string "password_digest", limit: 255
    t.string "role", limit: 255, default: "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "website_pdfs", id: :serial, force: :cascade do |t|
    t.string "file", limit: 255
    t.string "file_name", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "employment_application_reviews", "employment_applications"
end
