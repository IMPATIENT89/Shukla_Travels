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

ActiveRecord::Schema[7.0].define(version: 2023_03_15_160102) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "country"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "booking_vehicles", force: :cascade do |t|
    t.integer "booking_id"
    t.integer "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.string "booking_from", null: false
    t.string "booking_to", null: false
    t.datetime "booking_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customer_id"
    t.integer "how_many_people"
    t.string "choose_car"
    t.float "amount_paid"
    t.string "stripe_transaction_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "customer_full_name"
    t.string "stripe_customer_id"
  end

  create_table "hostes", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.string "phone", null: false
    t.integer "no_of_cars"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "host_full_name"
  end

  create_table "hosts", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.string "phone"
    t.integer "no_of_cars"
    t.string "car_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "vehicle_no", null: false
    t.string "registration_no", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hoste_id"
    t.integer "no_of_seats"
    t.string "car_name"
  end

end
