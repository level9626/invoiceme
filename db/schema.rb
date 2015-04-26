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

ActiveRecord::Schema.define(version: 20150426135212) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: true do |t|
    t.string   "name"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "client_id"
  end

  add_index "clients_users", ["user_id", "client_id"], name: "index_clients_users_on_user_id_and_client_id", unique: true, using: :btree

  create_table "companies", force: true do |t|
    t.string   "logo"
    t.string   "name",                       null: false
    t.text     "address",                    null: false
    t.integer  "user_id",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "default",    default: false, null: false
  end

  add_index "companies", ["user_id"], name: "index_companies_on_user_id", using: :btree

  create_table "invoice_items", force: true do |t|
    t.string   "description",    default: "", null: false
    t.float    "hours_or_tasks",              null: false
    t.float    "rate",                        null: false
    t.integer  "invoice_id",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "amount",                      null: false
  end

  add_index "invoice_items", ["invoice_id"], name: "index_invoice_items_on_invoice_id", using: :btree

  create_table "invoices", force: true do |t|
    t.string   "invoice_number",                              null: false
    t.datetime "invoice_date",                                null: false
    t.integer  "user_id",                                     null: false
    t.string   "currency",                                    null: false
    t.text     "comment",                     default: "",    null: false
    t.integer  "company_id",                                  null: false
    t.integer  "client_id",                                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "company_row_text",                            null: false
    t.text     "client_row_text",                             null: false
    t.float    "subtotal",                                    null: false
    t.float    "vat_rate"
    t.float    "vat"
    t.float    "discount"
    t.string   "state",            limit: 20, default: "new", null: false
  end

  add_index "invoices", ["invoice_number", "client_id", "company_id"], name: "index_invoices_on_invoice_number_and_client_id_and_company_id", unique: true, using: :btree
  add_index "invoices", ["invoice_number"], name: "index_invoices_on_invoice_number", using: :btree
  add_index "invoices", ["state"], name: "index_invoices_on_state", using: :btree

  create_table "journals", force: true do |t|
    t.integer  "invoice_id"
    t.string   "event",      limit: 20
    t.string   "from",       limit: 20
    t.string   "to",         limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.integer  "invoice_id", null: false
    t.float    "amount",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["invoice_id"], name: "index_payments_on_invoice_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
