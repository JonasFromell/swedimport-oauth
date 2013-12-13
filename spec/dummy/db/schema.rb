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

ActiveRecord::Schema.define(version: 20131212144235) do

  create_table "oauth_authorizations", force: true do |t|
    t.string   "application_id", null: false
    t.string   "redirect_uri",   null: false
    t.string   "code",           null: false
    t.datetime "expires_at",     null: false
    t.integer  "user_id"
  end

  add_index "oauth_authorizations", ["application_id", "redirect_uri"], name: "index_oauth_authorizations_on_application_id_and_redirect_uri"
  add_index "oauth_authorizations", ["user_id"], name: "index_oauth_authorizations_on_user_id"

  create_table "oauth_clients", force: true do |t|
    t.string "name",               null: false
    t.string "application_id",     null: false
    t.string "application_secret", null: false
    t.string "redirect_uri",       null: false
  end

  add_index "oauth_clients", ["application_id", "application_secret"], name: "index_oauth_clients_on_application_id_and_application_secret", unique: true
  add_index "oauth_clients", ["application_id", "redirect_uri"], name: "index_oauth_clients_on_application_id_and_redirect_uri", unique: true
  add_index "oauth_clients", ["application_id"], name: "index_oauth_clients_on_application_id"

  create_table "oauth_tokens", force: true do |t|
    t.integer  "client_id"
    t.string   "token",         null: false
    t.string   "refresh_token"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_tokens", ["client_id", "token"], name: "index_oauth_tokens_on_client_id_and_token"
  add_index "oauth_tokens", ["client_id"], name: "index_oauth_tokens_on_client_id"
  add_index "oauth_tokens", ["refresh_token"], name: "index_oauth_tokens_on_refresh_token"
  add_index "oauth_tokens", ["token"], name: "index_oauth_tokens_on_token"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "name",                   default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
