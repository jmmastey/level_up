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

ActiveRecord::Schema.define(version: 20160620154316) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name", limit: 200, null: false
    t.string "handle", limit: 60, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "sort_order"
    t.boolean "hidden", default: true
    t.integer "difficulty"
    t.integer "course_id"
    t.string "organization", limit: 50
    t.index ["handle"], name: "index_categories_on_handle"
  end

  create_table "completions", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "skill_id"
    t.date "verified_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["skill_id"], name: "index_completions_on_skill_id"
    t.index ["user_id", "skill_id"], name: "index_completions_on_user_id_and_skill_id", unique: true
    t.index ["user_id"], name: "index_completions_on_user_id"
  end

  create_table "courses", id: :serial, force: :cascade do |t|
    t.string "name", limit: 200, null: false
    t.string "handle", limit: 60, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "status", limit: 20, default: "created", null: false
    t.text "description"
    t.string "organization", limit: 50
    t.integer "sort_order", default: 99
    t.index ["handle"], name: "index_courses_on_handle"
  end

  create_table "deadlines", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "category_id", null: false
    t.date "target_completed_on"
    t.date "completed_on"
    t.datetime "reminder_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enrollments", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "progress_reminder_sent_at"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "skills", id: :serial, force: :cascade do |t|
    t.string "name", limit: 200, null: false
    t.string "handle", limit: 60, null: false
    t.text "sample_solution"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "category_id"
    t.index ["handle"], name: "index_skills_on_handle"
  end

  create_table "unsubscribe_links", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name", limit: 100, null: false
    t.string "provider"
    t.string "uid"
    t.string "authentication_token"
    t.boolean "enrollment_reminder_sent", default: false
    t.string "organization", limit: 50
    t.datetime "slack_invite_sent_at"
    t.string "email_opt_out"
    t.string "deadline_mode"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

end
