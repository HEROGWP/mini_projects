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

ActiveRecord::Schema.define(version: 20161022134758) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "status",       default: "draft"
    t.datetime "publish_time"
    t.index ["topic_id"], name: "index_comments_on_topic_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_favorites_on_topic_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_likes_on_topic_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "picturetable_type"
    t.integer  "picturetable_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.index ["picturetable_type", "picturetable_id"], name: "index_pictures_on_picturetable_type_and_picturetable_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "nickname"
    t.date     "birthday"
    t.text     "bio"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "subscribes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_subscribes_on_topic_id"
    t.index ["user_id"], name: "index_subscribes_on_user_id"
  end

  create_table "topic_categoryships", force: :cascade do |t|
    t.integer  "topic_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_topic_categoryships_on_category_id"
    t.index ["topic_id"], name: "index_topic_categoryships_on_topic_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "comments_count", default: 0
    t.integer  "views",          default: 0
    t.string   "status",         default: "draft"
    t.string   "tag"
    t.datetime "publish_time"
    t.index ["tag"], name: "index_topics_on_tag"
    t.index ["user_id"], name: "index_topics_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "role",                   default: "user"
    t.string   "fb_uid"
    t.string   "fb_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["fb_uid"], name: "index_users_on_fb_uid"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url_address"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "random"
    t.integer  "times"
  end

end
