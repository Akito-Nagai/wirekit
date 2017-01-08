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

ActiveRecord::Schema.define(version: 20170106100512) do

  create_table "attendees", force: :cascade do |t|
    t.string   "uuid",                           null: false
    t.integer  "lounge_id",                      null: false
    t.text     "name"
    t.text     "url"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "level",              default: 0, null: false
    t.integer  "status",             default: 1, null: false
    t.string   "remote_ip"
    t.text     "user_agent"
    t.text     "ext1"
    t.text     "ext2"
    t.text     "ext3"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["lounge_id"], name: "index_attendees_on_lounge_id"
    t.index ["uuid"], name: "index_attendees_on_uuid", unique: true
  end

  create_table "channel_attendees", force: :cascade do |t|
    t.string   "uuid",        null: false
    t.integer  "channel_id",  null: false
    t.integer  "attendee_id", null: false
    t.datetime "created_at",  null: false
    t.index ["attendee_id"], name: "index_channel_attendees_on_attendee_id"
    t.index ["channel_id"], name: "index_channel_attendees_on_channel_id"
    t.index ["uuid"], name: "index_channel_attendees_on_uuid", unique: true
  end

  create_table "channels", force: :cascade do |t|
    t.string   "uuid",               null: false
    t.integer  "lounge_id",          null: false
    t.string   "name"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["created_at"], name: "index_channels_on_created_at"
    t.index ["lounge_id", "name"], name: "index_channels_on_lounge_id_and_name", unique: true
    t.index ["uuid"], name: "index_channels_on_uuid", unique: true
  end

  create_table "lounges", force: :cascade do |t|
    t.string   "uuid",               null: false
    t.integer  "user_id",            null: false
    t.string   "name"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["created_at"], name: "index_lounges_on_created_at"
    t.index ["user_id", "name"], name: "index_lounges_on_user_id_and_name", unique: true
    t.index ["uuid"], name: "index_lounges_on_uuid", unique: true
  end

  create_table "message_attendees", force: :cascade do |t|
    t.integer  "message_id",  null: false
    t.integer  "attendee_id", null: false
    t.datetime "created_at",  null: false
    t.index ["attendee_id"], name: "index_message_attendees_on_attendee_id"
    t.index ["message_id"], name: "index_message_attendees_on_message_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "channel_id",          null: false
    t.integer  "channel_attendee_id", null: false
    t.text     "body"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.datetime "deleted_at",          null: false
    t.datetime "edited_at",           null: false
    t.index ["channel_attendee_id"], name: "index_messages_on_channel_attendee_id"
    t.index ["channel_id"], name: "index_messages_on_channel_id"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.string   "code",                     null: false
    t.string   "name",        default: "", null: false
    t.text     "policy",      default: "", null: false
    t.text     "description", default: "", null: false
    t.integer  "sort"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["code"], name: "index_roles_on_code", unique: true
    t.index ["created_at"], name: "index_roles_on_created_at"
    t.index ["updated_at"], name: "index_roles_on_updated_at"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_sessions_on_created_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "nick_name",              default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "bio"
    t.text     "note"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["created_at"], name: "index_users_on_created_at"
    t.index ["email"], name: "index_users_on_email"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["updated_at"], name: "index_users_on_updated_at"
  end

  create_table "users_roles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", unique: true
  end

end
