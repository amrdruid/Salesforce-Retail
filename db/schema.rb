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

ActiveRecord::Schema.define(version: 2021_03_14_094901) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contact_infos", force: :cascade do |t|
    t.string "street"
    t.string "city"
    t.string "zip"
    t.string "country"
    t.string "state"
    t.string "phone"
    t.bigint "dealer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dealer_id"], name: "index_contact_infos_on_dealer_id"
  end

  create_table "dealers", force: :cascade do |t|
    t.integer "sf_id", null: false
    t.string "category", null: false
    t.string "name", null: false
    t.float "longitude"
    t.float "latitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sf_id"], name: "index_dealers_on_sf_id"
  end

  add_foreign_key "contact_infos", "dealers"
end
