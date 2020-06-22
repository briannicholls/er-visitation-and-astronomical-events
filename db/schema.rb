# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_22_062536) do

  create_table "diagnoses", force: :cascade do |t|
    t.string "code"
    t.string "description_long"
    t.string "description_short"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "moon_phases", force: :cascade do |t|
    t.datetime "date"
    t.float "frac_of_period_from_full_moon"
  end

  create_table "visits", force: :cascade do |t|
    t.datetime "date"
    t.datetime "dob"
    t.integer "diagnosis_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "raw_code"
    t.index ["diagnosis_id"], name: "index_visits_on_diagnosis_id"
  end

  add_foreign_key "visits", "diagnoses"
end
