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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111219201108) do

  create_table "accounts", :force => true do |t|
    t.string   "login",                                                        :null => false
    t.string   "password",                                                     :null => false
    t.boolean  "active",                                     :default => true, :null => false
    t.decimal  "balance",    :precision => 20, :scale => 10, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_permissions", :force => true do |t|
    t.integer  "admin_id"
    t.integer  "permission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins", :force => true do |t|
    t.string   "login",                                                 :null => false
    t.string   "email",                               :default => "",   :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",   :null => false
    t.string   "authentication_token"
    t.datetime "remember_created_at"
    t.boolean  "active",                              :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["authentication_token"], :name => "index_admins_on_authentication_token", :unique => true
  add_index "admins", ["login"], :name => "index_admins_on_login", :unique => true

  create_table "assigned_services", :force => true do |t|
    t.integer  "service_id", :null => false
    t.integer  "plan_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "options", :force => true do |t|
    t.integer  "service_id",                     :null => false
    t.string   "name",                           :null => false
    t.string   "title",                          :null => false
    t.boolean  "required",    :default => false, :null => false
    t.boolean  "overridable", :default => false, :null => false
    t.integer  "value_type",                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", :force => true do |t|
    t.string   "subject_class", :null => false
    t.string   "action",        :null => false
    t.string   "name",          :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plans", :force => true do |t|
    t.string   "name",                          :null => false
    t.string   "code",                          :null => false
    t.boolean  "active",     :default => true,  :null => false
    t.boolean  "legacy",     :default => false, :null => false
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "properties", :force => true do |t|
    t.integer  "option_id",           :null => false
    t.integer  "assigned_service_id"
    t.integer  "service_link_id"
    t.string   "value",               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_links", :force => true do |t|
    t.integer  "account_id",                             :null => false
    t.integer  "assigned_service_id",                    :null => false
    t.boolean  "scheduled",           :default => false, :null => false
    t.boolean  "expiring",            :default => false, :null => false
    t.boolean  "active",              :default => true,  :null => false
    t.datetime "start_at"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :force => true do |t|
    t.string   "name",                          :null => false
    t.string   "title",                         :null => false
    t.text     "description"
    t.boolean  "active",      :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "account_id",                                :null => false
    t.decimal  "amount",     :precision => 12, :scale => 2, :null => false
    t.integer  "code",                                      :null => false
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
