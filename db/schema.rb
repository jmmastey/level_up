# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150118051902) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name",         limit: 200,                null: false
    t.string   "handle",       limit: 60,                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sort_order"
    t.boolean  "hidden",                   default: true
    t.integer  "difficulty"
    t.integer  "course_id"
    t.string   "organization", limit: 50
  end

  add_index "categories", ["handle"], name: "index_categories_on_handle", using: :btree

  create_table "completions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "skill_id"
    t.date     "verified_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "completions", ["skill_id"], name: "index_completions_on_skill_id", using: :btree
  add_index "completions", ["user_id", "skill_id"], name: "index_completions_on_user_id_and_skill_id", unique: true, using: :btree
  add_index "completions", ["user_id"], name: "index_completions_on_user_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "name",        limit: 200,                     null: false
    t.string   "handle",      limit: 60,                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",      limit: 20,  default: "created", null: false
    t.text     "description"
  end

  add_index "courses", ["handle"], name: "index_courses_on_handle", using: :btree

  create_table "enrollments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "skills", force: :cascade do |t|
    t.string   "name",            limit: 200, null: false
    t.string   "handle",          limit: 60,  null: false
    t.text     "sample_solution"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  add_index "skills", ["handle"], name: "index_skills_on_handle", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                                default: "",    null: false
    t.string   "encrypted_password",                   default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                     limit: 100,                 null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "authentication_token"
    t.boolean  "enrollment_reminder_sent",             default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
