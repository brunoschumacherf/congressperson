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

ActiveRecord::Schema.define(version: 2022_08_14_164049) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ceaps", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.float "total_spend"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "deputies", force: :cascade do |t|
    t.string "name"
    t.string "state"
    t.string "document"
    t.string "photo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "ceap_id", null: false
    t.index ["ceap_id"], name: "index_deputies_on_ceap_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.time "date"
    t.string "establishment"
    t.float "value"
    t.string "note"
    t.string "phone"
    t.string "document"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "deputy_id", null: false
    t.index ["deputy_id"], name: "index_expenses_on_deputy_id"
  end

  add_foreign_key "deputies", "ceaps"
  add_foreign_key "expenses", "deputies"
end
