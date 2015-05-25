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

ActiveRecord::Schema.define(version: 20150525150217) do

  create_table "broadcasts", force: :cascade do |t|
    t.string   "url",        limit: 255, null: false
    t.string   "platform",   limit: 255, null: false
    t.string   "player_url", limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "room_id",    limit: 4,   null: false
    t.integer  "user_id",    limit: 4
    t.string   "body",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "room_users", force: :cascade do |t|
    t.integer  "room_id",    limit: 4, null: false
    t.integer  "user_id",    limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "name",          limit: 255,                 null: false
    t.string   "url_token",     limit: 255,                 null: false
    t.integer  "number",        limit: 4,                   null: false
    t.integer  "owner_id",      limit: 4,                   null: false
    t.boolean  "private",       limit: 1,   default: false, null: false
    t.boolean  "deletable",     limit: 1,   default: false, null: false
    t.integer  "active_number", limit: 4,   default: 0,     null: false
    t.boolean  "full",          limit: 1,   default: false, null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "nickname",        limit: 255, null: false
    t.string   "password_digest", limit: 255, null: false
    t.string   "room_url_token",  limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
