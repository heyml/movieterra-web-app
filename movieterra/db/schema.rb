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

ActiveRecord::Schema.define(version: 20170927133735) do

  create_table "movies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "planetakino_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies_recommendations", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "movie_id", null: false
    t.bigint "recommendation_id", null: false
    t.index ["movie_id", "recommendation_id"], name: "index_movies_recommendations_on_movie_id_and_recommendation_id"
    t.index ["recommendation_id", "movie_id"], name: "index_movies_recommendations_on_recommendation_id_and_movie_id"
  end

  create_table "nopassword_login_sessions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email"
    t.string "hashed_code"
    t.string "requesting_ip"
    t.string "requesting_user_agent"
    t.string "activating_ip"
    t.string "activating_user_agent"
    t.boolean "activated", default: false
    t.timestamp "activated_at"
    t.boolean "terminated", default: false
    t.timestamp "terminated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "requesting_geo"
    t.string "activating_geo"
  end

  create_table "tickets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.integer "tmdb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
  end

  add_foreign_key "tickets", "users"
end
