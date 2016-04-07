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

ActiveRecord::Schema.define(version: 20160406031210) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", primary_key: "contact_id", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "email",        null: false
    t.string "dorm"
  end

  create_table "message_bcc_recipients", force: :cascade do |t|
    t.integer "message_id", null: false
    t.integer "contact_id", null: false
  end

  create_table "message_cc_recipients", force: :cascade do |t|
    t.integer "message_id", null: false
    t.integer "contact_id", null: false
  end

  create_table "message_recipients", force: :cascade do |t|
    t.integer "message_id", null: false
    t.integer "contact_id", null: false
  end

  create_table "messages", primary_key: "message_id", force: :cascade do |t|
    t.integer "sender_contact_id", null: false
    t.string  "direction",         null: false
    t.string  "subject",           null: false
    t.text    "content",           null: false
    t.text    "attachments"
  end

  add_foreign_key "message_bcc_recipients", "contacts", primary_key: "contact_id"
  add_foreign_key "message_bcc_recipients", "messages", primary_key: "message_id"
  add_foreign_key "message_cc_recipients", "contacts", primary_key: "contact_id"
  add_foreign_key "message_cc_recipients", "messages", primary_key: "message_id"
  add_foreign_key "message_recipients", "contacts", primary_key: "contact_id"
  add_foreign_key "message_recipients", "messages", primary_key: "message_id"
  add_foreign_key "messages", "contacts", column: "sender_contact_id", primary_key: "contact_id"
end
