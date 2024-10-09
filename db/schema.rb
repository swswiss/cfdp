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

ActiveRecord::Schema[7.2].define(version: 2024_10_09_222519) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activity_logs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "action"
    t.string "trackable_type"
    t.integer "trackable_id"
    t.datetime "timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["user_id"], name: "index_activity_logs_on_user_id"
  end

  create_table "bridges", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.boolean "published", default: false, null: false
    t.string "tip_lucrare_arta"
    t.string "obstacol_traversat"
    t.string "localitatea"
    t.string "categoria"
    t.string "numar_drum"
    t.string "clasa"
    t.string "pozitia_km"
    t.string "an_constructie"
    t.string "schema_statica"
    t.string "structura_rezistenta"
    t.string "mod_executie"
    t.string "oblicitate"
    t.string "culee_fundatie_simplu"
    t.string "culee_fundatie_armat"
    t.string "culee_fundatie_precomprimat"
    t.string "culee_fundatie_metal"
    t.string "culee_fundatie_lemn"
    t.string "culee_fundatie_mixt"
    t.string "culee_elevatie_simplu"
    t.string "culee_elevatie_armat"
    t.string "culee_elevatie_precomprimat"
    t.string "culee_elevatie_metal"
    t.string "culee_elevatie_lemn"
    t.string "culee_elevatie_mixt"
    t.string "pile_fundatie_simplu"
    t.string "pile_fundatie_armat"
    t.string "pile_fundatie_precomprimat"
    t.string "pile_fundatie_metal"
    t.string "pile_fundatie_lemn"
    t.string "pile_fundatie_mixt"
    t.string "pile_elevatie_simplu"
    t.string "pile_elevatie_armat"
    t.string "pile_elevatie_precomprimat"
    t.string "pile_elevatie_metal"
    t.string "pile_elevatie_lemn"
    t.string "pile_elevatie_mixt"
    t.string "structura_rezistenta_simplu"
    t.string "structura_rezistenta_armat"
    t.string "structura_rezistenta_precomprimat"
    t.string "structura_rezistenta_metal"
    t.string "structura_rezistenta_lemn"
    t.string "structura_rezistenta_mixt"
    t.string "lungime"
    t.string "numar_deschideri"
    t.string "lungime_deschidere"
    t.string "latime"
    t.string "aparate_reazem"
    t.string "tip_infrastructurii"
    t.string "tip_fundatii"
    t.string "tip_imbracaminte"
    t.string "rosturi_tip_pozitie"
    t.string "parapeti_pietonali"
    t.string "parapeti_siguranta"
    t.string "racordari_terasamente"
    t.string "aparari_mal"
    t.string "latime_carosabila"
    t.string "latime_trotuar"
    t.string "numar_grinzi"
    t.string "numar_antretoaze"
    t.index ["slug"], name: "index_bridges_on_slug", unique: true
    t.index ["user_id"], name: "index_bridges_on_user_id"
  end

  create_table "instance_bridges", force: :cascade do |t|
    t.bigint "bridge_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bridge_id"], name: "index_instance_bridges_on_bridge_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "firstname"
    t.string "lastname"
    t.string "username"
    t.string "role", default: "student"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "activity_logs", "users"
  add_foreign_key "bridges", "users"
  add_foreign_key "instance_bridges", "bridges"
end
