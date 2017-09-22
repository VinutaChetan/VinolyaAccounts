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

ActiveRecord::Schema.define(version: 20170921064217) do

  create_table "accounts", force: :cascade do |t|
    t.string   "acc_no"
    t.float    "opening_balance"
    t.integer  "bank_id"
    t.integer  "branch_id"
    t.string   "acc_type"
    t.float    "current_balance"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "company_id"
    t.datetime "deleted_at"
    t.string   "IFSC"
  end

  add_index "accounts", ["deleted_at"], name: "index_accounts_on_deleted_at"

  create_table "banks", force: :cascade do |t|
    t.string   "name"
    t.text     "address"
    t.string   "manager"
    t.string   "contact_details"
    t.integer  "branch_id"
    t.integer  "company_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "link"
    t.datetime "deleted_at"
  end

  add_index "banks", ["deleted_at"], name: "index_banks_on_deleted_at"

  create_table "branches", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  add_index "branches", ["deleted_at"], name: "index_branches_on_deleted_at"

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "deleted_at"
    t.string   "contact_number"
    t.text     "address"
    t.string   "mail_id"
  end

  add_index "companies", ["deleted_at"], name: "index_companies_on_deleted_at"

  create_table "perticulars", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.datetime "deleted_at"
    t.string   "perticular_type"
  end

  add_index "perticulars", ["deleted_at"], name: "index_perticulars_on_deleted_at"

  create_table "rtos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.date     "transaction_date"
    t.integer  "perticular_id"
    t.string   "transaction_type"
    t.text     "remark"
    t.string   "transaction_kind"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "account_id"
    t.float    "amount"
    t.integer  "company_id"
    t.datetime "deleted_at"
    t.date     "instrument_date"
    t.string   "instrument_number"
    t.float    "balance"
  end

  add_index "transactions", ["deleted_at"], name: "index_transactions_on_deleted_at"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "userid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
