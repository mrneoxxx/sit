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

ActiveRecord::Schema.define(version: 20170423182542) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: :cascade do |t|
    t.integer  "ticket_comment_id"
    t.integer  "user_id"
    t.integer  "status_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["status_id"], name: "index_assignments_on_status_id", using: :btree
    t.index ["ticket_comment_id"], name: "index_assignments_on_ticket_comment_id", using: :btree
    t.index ["user_id"], name: "index_assignments_on_user_id", using: :btree
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.string   "searchable_type"
    t.integer  "searchable_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id", using: :btree
  end

  create_table "status_groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "title"
    t.integer  "sorter"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "status_group_id"
    t.index ["status_group_id"], name: "index_statuses_on_status_group_id", using: :btree
  end

  create_table "ticket_comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "ticket_id"
    t.text     "body",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_ticket_comments_on_ticket_id", using: :btree
    t.index ["user_id"], name: "index_ticket_comments_on_user_id", using: :btree
  end

  create_table "tickets", force: :cascade do |t|
    t.string   "reference",     null: false
    t.string   "customer"
    t.string   "title",         null: false
    t.integer  "department_id"
    t.integer  "status_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["customer"], name: "index_tickets_on_customer", using: :btree
    t.index ["department_id"], name: "index_tickets_on_department_id", using: :btree
    t.index ["reference"], name: "index_tickets_on_reference", unique: true, using: :btree
    t.index ["status_id"], name: "index_tickets_on_status_id", using: :btree
    t.index ["user_id"], name: "index_tickets_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "name",                                null: false
    t.integer  "department_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["department_id"], name: "index_users_on_department_id", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
