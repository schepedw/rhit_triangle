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

ActiveRecord::Schema.define(version: 20170119033936) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_officers", force: :cascade do |t|
    t.string  "title",     null: false
    t.integer "member_id", null: false
  end

  create_table "addresses", primary_key: "address_id", force: :cascade do |t|
    t.integer "member_id"
    t.string  "street_line_1", null: false
    t.string  "street_line_2"
    t.string  "city",          null: false
    t.string  "state",         null: false
    t.string  "zip_code",      null: false
  end

  create_table "alumni_officers", force: :cascade do |t|
    t.string  "title",           null: false
    t.integer "member_id",       null: false
    t.text    "bio"
    t.text    "job_description"
  end

  create_table "channel_members", id: false, force: :cascade do |t|
    t.integer "channel_id", null: false
    t.integer "member_id",  null: false
  end

  add_index "channel_members", ["channel_id"], name: "index_channel_members_on_channel_id", using: :btree
  add_index "channel_members", ["member_id"], name: "index_channel_members_on_member_id", using: :btree

  create_table "channels", primary_key: "channel_id", force: :cascade do |t|
    t.text     "subject",                        null: false
    t.text     "description",                    null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "visibility",  default: "public", null: false
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
    t.integer  "member_id",                                                    null: false
    t.integer  "project_id",                                                   null: false
    t.string   "visibility",                               default: "private", null: false
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.string   "frequency",                                                    null: false
    t.text     "message"
    t.decimal  "recurring_amount", precision: 7, scale: 2,                     null: false
  end

  create_table "installments", primary_key: "installment_id", force: :cascade do |t|
    t.integer  "donation_id",                         null: false
    t.decimal  "amount",      precision: 7, scale: 2, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
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
    t.string   "title"
    t.text     "bio"
    t.string   "screen_name",                         null: false
  end

  add_index "members", ["email"], name: "index_members_on_email", unique: true, using: :btree
  add_index "members", ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true, using: :btree

  create_table "members_roles", id: false, force: :cascade do |t|
    t.integer "member_id"
    t.integer "role_id"
  end

  add_index "members_roles", ["member_id", "role_id"], name: "index_members_roles_on_member_id_and_role_id", using: :btree

  create_table "message_recipients", force: :cascade do |t|
    t.integer  "message_id",                      null: false
    t.integer  "contact_id",                      null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "bcc",             default: false, null: false
    t.boolean  "cc",              default: false, null: false
    t.string   "owner_type",                      null: false
    t.integer  "notification_id"
  end

  create_table "messages", primary_key: "message_id", force: :cascade do |t|
    t.integer  "from_id",     null: false
    t.string   "direction",   null: false
    t.string   "subject",     null: false
    t.text     "content",     null: false
    t.text     "attachments"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "to_id",       null: false
  end

  create_table "notifications", primary_key: "notification_id", force: :cascade do |t|
    t.integer  "post_id",                      null: false
    t.integer  "recipient_id",                 null: false
    t.integer  "notifier_id",                  null: false
    t.boolean  "acknowledged", default: false, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "phone_numbers", primary_key: "phone_number_id", force: :cascade do |t|
    t.integer  "member_id",                            null: false
    t.string   "phone_number",                         null: false
    t.string   "phone_number_type", default: "mobile"
    t.boolean  "primary",           default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", primary_key: "post_id", force: :cascade do |t|
    t.text     "content",    null: false
    t.integer  "author_id",  null: false
    t.integer  "parent_id"
    t.integer  "channel_id", null: false
    t.integer  "depth",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["channel_id"], name: "index_posts_on_channel_id", using: :btree

  create_table "project_pictures", primary_key: "project_picture_id", force: :cascade do |t|
    t.string  "image_path", null: false
    t.integer "project_id", null: false
  end

  create_table "project_statuses", primary_key: "project_status_id", force: :cascade do |t|
    t.string "status", default: "backlog"
  end

  create_table "projects", primary_key: "project_id", force: :cascade do |t|
    t.string   "title",                                                                                            null: false
    t.text     "description",                                                                                      null: false
    t.integer  "project_status_id",                                                                                null: false
    t.decimal  "price",             precision: 7, scale: 2,                                                        null: false
    t.datetime "created_at",                                                                                       null: false
    t.datetime "updated_at",                                                                                       null: false
    t.integer  "sort_val",                                  default: "nextval('projects_sort_val_seq'::regclass)"
  end

  create_table "reactions", primary_key: "reaction_id", force: :cascade do |t|
    t.string  "reaction_text", null: false
    t.integer "member_id",     null: false
    t.integer "post_id",       null: false
  end

  add_index "reactions", ["member_id"], name: "index_reactions_on_member_id", using: :btree
  add_index "reactions", ["post_id"], name: "index_reactions_on_post_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "title",           null: false
    t.integer  "member_id",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "job_description"
    t.string   "role_type"
  end

  add_index "roles", ["title"], name: "index_roles_on_title", using: :btree

  add_foreign_key "active_officers", "members", primary_key: "member_id", name: "memberfk"
  add_foreign_key "addresses", "members", primary_key: "member_id"
  add_foreign_key "alumni_officers", "members", primary_key: "member_id", name: "memberfk"
  add_foreign_key "channel_members", "channels", primary_key: "channel_id", name: "channel_id_fk"
  add_foreign_key "channel_members", "members", primary_key: "member_id", name: "member_id_fk"
  add_foreign_key "donations", "members", primary_key: "member_id"
  add_foreign_key "donations", "projects", primary_key: "project_id"
  add_foreign_key "installments", "donations", primary_key: "donation_id"
  add_foreign_key "members", "members", column: "pledge_father_id", primary_key: "member_id"
  add_foreign_key "message_recipients", "contacts", primary_key: "contact_id"
  add_foreign_key "message_recipients", "messages", primary_key: "message_id"
  add_foreign_key "messages", "members", column: "from_id", primary_key: "member_id", name: "from_memberfk"
  add_foreign_key "messages", "members", column: "to_id", primary_key: "member_id", name: "to_memberfk"
  add_foreign_key "notifications", "members", column: "notifier_id", primary_key: "member_id", name: "recipient_member_fk"
  add_foreign_key "notifications", "members", column: "recipient_id", primary_key: "member_id", name: "notifier_member_fk"
  add_foreign_key "notifications", "posts", primary_key: "post_id", on_delete: :cascade
  add_foreign_key "phone_numbers", "members", primary_key: "member_id"
  add_foreign_key "posts", "channels", primary_key: "channel_id", name: "channel_id_fk"
  add_foreign_key "posts", "members", column: "author_id", primary_key: "member_id", name: "author_id_fk"
  add_foreign_key "posts", "posts", column: "parent_id", primary_key: "post_id", name: "parent_id_fk", on_delete: :cascade
  add_foreign_key "project_pictures", "projects", primary_key: "project_id"
  add_foreign_key "projects", "project_statuses", primary_key: "project_status_id"
  add_foreign_key "reactions", "members", primary_key: "member_id", name: "member_id_fk", on_delete: :cascade
  add_foreign_key "reactions", "posts", primary_key: "post_id", name: "post_id_fk", on_delete: :cascade
  execute(<<-SQL
                     ALTER TABLE members ALTER COLUMN screen_name SET NOT NULL;
                     CREATE FUNCTION create_screen_name() RETURNS trigger AS $create_screen_name$
                      BEGIN
                        IF NEW.screen_name IS NULL THEN
                          NEW.screen_name := lower(NEW.first_name) || '.' || lower(NEW.last_name);
                        END IF;
                        RETURN NEW;
                      END;
                     $create_screen_name$ LANGUAGE plpgsql;

                     CREATE TRIGGER create_screen_name BEFORE INSERT OR UPDATE OF first_name, last_name ON members
                     FOR EACH ROW
                     EXECUTE PROCEDURE create_screen_name();

                     CREATE UNIQUE INDEX idx_member_screen_name ON members(lower(screen_name))
          SQL
         )
end
