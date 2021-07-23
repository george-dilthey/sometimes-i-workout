# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_23_202926) do

  create_table "segments", force: :cascade do |t|
    t.string "name"
    t.float "distance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "polyline"
    t.string "map"
    t.boolean "starred"
  end

  create_table "segments_workouts", id: false, force: :cascade do |t|
    t.integer "segment_id"
    t.integer "workout_id"
    t.index ["segment_id"], name: "index_segments_workouts_on_segment_id"
    t.index ["workout_id"], name: "index_segments_workouts_on_workout_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
  end

  create_table "workouts", force: :cascade do |t|
    t.string "name"
    t.datetime "date"
    t.string "type"
    t.float "distance"
    t.integer "elapsed_time"
    t.boolean "public"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "polyline"
    t.string "map"
    t.index ["user_id"], name: "index_workouts_on_user_id"
  end

  add_foreign_key "workouts", "users"
end
