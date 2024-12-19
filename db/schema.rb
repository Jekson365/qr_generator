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

ActiveRecord::Schema[7.1].define(version: 2024_10_13_161129) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "qrcodes", force: :cascade do |t|
    t.string "url"
    t.string "version"
    t.string "box_size"
    t.string "border"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "path"
    t.index ["user_id"], name: "index_qrcodes_on_user_id"
  end

  create_table "user_finals", force: :cascade do |t|
    t.bigint "user_id"
    t.string "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_finals_on_user_id"
  end

  create_table "user_images", force: :cascade do |t|
    t.string "image_path"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_images_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "ip_address"
    t.string "user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
