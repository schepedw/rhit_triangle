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

ActiveRecord::Schema.define(version: 20160724192836) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", primary_key: "address_id", force: :cascade do |t|
    t.integer "member_id"
    t.string  "street_line_1", null: false
    t.string  "street_line_2"
    t.string  "city",          null: false
    t.string  "state",         null: false
    t.string  "zip_code",      null: false
  end

  create_table "contacts", primary_key: "contact_id", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "email",        null: false
    t.string   "dorm"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "donations", primary_key: "donation_id", force: :cascade do |t|
    t.integer  "member_id",                                              null: false
    t.integer  "project_id",                                             null: false
    t.decimal  "amount",     precision: 7, scale: 2,                     null: false
    t.string   "visibility",                         default: "private", null: false
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "frequency",                                              null: false
  end

  create_table "members", primary_key: "member_id", force: :cascade do |t|
    t.string   "first_name",                          null: false
    t.string   "middle_name"
    t.string   "last_name",                           null: false
    t.string   "hometown"
    t.integer  "graduation_year"
    t.integer  "initiation_year"
    t.integer  "pledge_father_id"
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "members", ["email"], name: "index_members_on_email", unique: true, using: :btree
  add_index "members", ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true, using: :btree

  create_table "members_roles", id: false, force: :cascade do |t|
    t.integer "member_id"
    t.integer "role_id"
  end

  add_index "members_roles", ["member_id", "role_id"], name: "index_members_roles_on_member_id_and_role_id", using: :btree

  create_table "message_bcc_recipients", primary_key: "message_bcc_recipient_id", force: :cascade do |t|
    t.integer  "message_id", null: false
    t.integer  "contact_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "message_cc_recipients", force: :cascade do |t|
    t.integer  "message_id", null: false
    t.integer  "contact_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "message_recipients", force: :cascade do |t|
    t.integer  "message_id", null: false
    t.integer  "contact_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", primary_key: "message_id", force: :cascade do |t|
    t.integer  "sender_contact_id", null: false
    t.string   "direction",         null: false
    t.string   "subject",           null: false
    t.text     "content",           null: false
    t.text     "attachments"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "phone_numbers", primary_key: "phone_number_id", force: :cascade do |t|
    t.integer "member_id",                            null: false
    t.string  "phone_number",                         null: false
    t.string  "phone_number_type", default: "mobile"
  end

  create_table "project_pictures", primary_key: "project_picture_id", force: :cascade do |t|
    t.string  "image_path", null: false
    t.integer "project_id", null: false
  end

  create_table "project_statuses", primary_key: "project_status_id", force: :cascade do |t|
    t.string "status", default: "backlog"
  end

  create_table "projects", primary_key: "project_id", force: :cascade do |t|
    t.string   "title",                                     null: false
    t.text     "description",                               null: false
    t.integer  "project_status_id",                         null: false
    t.decimal  "price",             precision: 7, scale: 2, null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
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

  add_foreign_key "addresses", "members", primary_key: "member_id"
  add_foreign_key "donations", "members", primary_key: "member_id"
  add_foreign_key "donations", "projects", primary_key: "project_id"
  add_foreign_key "members", "members", column: "pledge_father_id", primary_key: "member_id"
  add_foreign_key "message_bcc_recipients", "contacts", primary_key: "contact_id"
  add_foreign_key "message_bcc_recipients", "messages", primary_key: "message_id"
  add_foreign_key "message_cc_recipients", "contacts", primary_key: "contact_id"
  add_foreign_key "message_cc_recipients", "messages", primary_key: "message_id"
  add_foreign_key "message_recipients", "contacts", primary_key: "contact_id"
  add_foreign_key "message_recipients", "messages", primary_key: "message_id"
  add_foreign_key "messages", "contacts", column: "sender_contact_id", primary_key: "contact_id"
  add_foreign_key "phone_numbers", "members", primary_key: "member_id"
  add_foreign_key "project_pictures", "projects", primary_key: "project_id"
  add_foreign_key "projects", "project_statuses", primary_key: "project_status_id"
end
