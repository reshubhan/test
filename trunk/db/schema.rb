# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100630091148) do

  create_table "adverts", :force => true do |t|
    t.string   "name"
    t.string   "link"
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "adverts_assets", :id => false, :force => true do |t|
    t.integer "advert_id"
    t.integer "asset_id"
  end

  create_table "adverts_geographies", :id => false, :force => true do |t|
    t.integer "advert_id"
    t.integer "geography_id"
  end

  create_table "answers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "option_id"
  end

  create_table "asset_attribute_managers", :force => true do |t|
    t.integer "user_id",            :null => false
    t.string  "manager_id",         :null => false
    t.integer "asset_attribute_id", :null => false
    t.integer "votes"
  end

  add_index "asset_attribute_managers", ["asset_attribute_id"], :name => "index_asset_attribute_managers_on_asset_attribute_id"
  add_index "asset_attribute_managers", ["id"], :name => "index_asset_attribute_managers_on_id", :unique => true
  add_index "asset_attribute_managers", ["manager_id"], :name => "index_asset_attribute_managers_on_manager_id"
  add_index "asset_attribute_managers", ["user_id"], :name => "index_asset_attribute_managers_on_user_id"

  create_table "asset_attributes", :force => true do |t|
    t.integer "asset_id"
    t.integer "attribute_id"
    t.string  "attribute_type"
  end

  add_index "asset_attributes", ["asset_id"], :name => "index_asset_attributes_on_asset_id"
  add_index "asset_attributes", ["attribute_id"], :name => "index_asset_attributes_on_attribute_id"
  add_index "asset_attributes", ["id"], :name => "index_asset_attributes_on_id", :unique => true

  create_table "assets", :force => true do |t|
    t.string   "name",                                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.integer  "parent_id"
    t.string   "default_size"
    t.integer  "default_type"
    t.integer  "default_geo"
    t.string   "default_fund_size"
    t.integer  "advert_id"
    t.boolean  "active_asset",      :default => false
    t.boolean  "default_asset",     :default => false
  end

  add_index "assets", ["id"], :name => "index_assets_on_id", :unique => true
  add_index "assets", ["name"], :name => "index_assets_on_name"

  create_table "assets_companies", :id => false, :force => true do |t|
    t.integer "asset_id",   :null => false
    t.integer "company_id", :null => false
  end

  create_table "assets_funds", :id => false, :force => true do |t|
    t.integer "asset_id", :null => false
    t.integer "fund_id",  :null => false
  end

  create_table "assets_managers", :force => true do |t|
    t.integer  "asset_id"
    t.integer  "manager_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assets_managers", ["asset_id"], :name => "index_assets_managers_on_asset_id"
  add_index "assets_managers", ["id"], :name => "index_assets_managers_on_id", :unique => true
  add_index "assets_managers", ["manager_id"], :name => "index_assets_managers_on_manager_id"

  create_table "attributes", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by"
    t.integer  "created_by"
  end

  add_index "attributes", ["id"], :name => "index_attributes_on_id", :unique => true
  add_index "attributes", ["name"], :name => "index_attributes_on_name"

  create_table "classified_funds", :force => true do |t|
    t.string   "classified_fund_type"
    t.integer  "manager_id"
    t.integer  "user_id"
    t.integer  "approver_id"
    t.datetime "approved_at"
    t.string   "status",               :default => "approved"
    t.text     "description"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "position"
    t.string   "fund_size"
    t.integer  "geography_id"
    t.integer  "asset_id"
    t.integer  "asset_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fund_id"
    t.string   "token"
    t.integer  "desired_size_id"
  end

  add_index "classified_funds", ["desired_size_id"], :name => "index_classified_funds_on_desired_size_id"

  create_table "classified_funds_funds", :id => false, :force => true do |t|
    t.integer "fund_id",            :null => false
    t.integer "classified_fund_id", :null => false
  end

  create_table "classified_funds_sectors", :id => false, :force => true do |t|
    t.integer "sector_id",          :null => false
    t.integer "classified_fund_id", :null => false
  end

  create_table "comment_ratings", :force => true do |t|
    t.integer "comment_id", :null => false
    t.integer "user_id",    :null => false
    t.string  "rate",       :null => false
  end

  create_table "comments", :force => true do |t|
    t.string   "body",             :limit => 2000,                             :null => false
    t.integer  "user_id"
    t.integer  "manager_id"
    t.boolean  "flag",                             :default => false
    t.string   "relationship"
    t.string   "experience_level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",                           :default => "approved"
    t.integer  "parent_id"
    t.string   "title",                            :default => "New Commment", :null => false
  end

  add_index "comments", ["id"], :name => "index_comments_on_id", :unique => true
  add_index "comments", ["manager_id"], :name => "index_comments_on_manager_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "company_type"
    t.float    "revenue_per_year"
    t.integer  "currency"
    t.boolean  "new_financing"
    t.integer  "geography_id"
    t.string   "type_of_financing"
    t.string   "posted_by"
    t.text     "description"
    t.integer  "asset_id"
    t.string   "status",            :default => "approved"
    t.integer  "user_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "asset_type_id"
    t.boolean  "featured",          :default => false
    t.integer  "desired_size_id"
  end

  add_index "companies", ["desired_size_id"], :name => "index_companies_on_desired_size_id"

  create_table "companies_sectors", :id => false, :force => true do |t|
    t.integer "sector_id",  :null => false
    t.integer "company_id", :null => false
  end

  create_table "currencies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "desired_sizes", :force => true do |t|
    t.string "name"
    t.float  "size_in_billions"
  end

  create_table "emails", :force => true do |t|
    t.string   "from"
    t.string   "to"
    t.integer  "last_send_attempt", :default => 0
    t.text     "mail"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "fund_sizes", :force => true do |t|
    t.string "name"
    t.float  "size_in_billions"
  end

  create_table "funds", :force => true do |t|
    t.string   "name",                                :null => false
    t.float    "size",        :default => 0.0,        :null => false
    t.integer  "year",                                :null => false
    t.integer  "manager_id",                          :null => false
    t.integer  "user_id",                             :null => false
    t.integer  "approver_id"
    t.datetime "approved_at"
    t.string   "status",      :default => "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "overview"
    t.string   "portfolio"
    t.boolean  "in_market",   :default => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.string   "fund_type"
    t.integer  "currency"
    t.string   "investors"
    t.float    "irr"
    t.float    "multiple"
    t.integer  "seller_id"
  end

  add_index "funds", ["id"], :name => "index_funds_on_id", :unique => true
  add_index "funds", ["name"], :name => "index_funds_on_name"

  create_table "funds_sectors", :id => false, :force => true do |t|
    t.integer "fund_id",   :null => false
    t.integer "sector_id", :null => false
  end

  create_table "geographies", :force => true do |t|
    t.string  "name",       :null => false
    t.integer "created_by"
    t.integer "updated_by"
    t.integer "created_at"
    t.integer "updated_at"
    t.integer "advert_id"
  end

  add_index "geographies", ["id"], :name => "index_geographies_on_id", :unique => true
  add_index "geographies", ["name"], :name => "index_geographies_on_name"

  create_table "logs", :force => true do |t|
    t.string   "action",     :null => false
    t.string   "message",    :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "managers", :force => true do |t|
    t.string   "name",                                                      :null => false
    t.string   "url",                                                       :null => false
    t.integer  "geography_id",                                              :null => false
    t.integer  "asset_primary_id",                                          :null => false
    t.integer  "asset_secondary_id"
    t.integer  "user_id",                                                   :null => false
    t.integer  "approver_id"
    t.datetime "approved_at"
    t.string   "status",                            :default => "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description",        :limit => 700
    t.string   "geography_sub"
    t.string   "image_remote_url"
    t.string   "image"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.boolean  "featured"
    t.string   "new_name"
    t.string   "new_url"
  end

  add_index "managers", ["id"], :name => "index_managers_on_id", :unique => true
  add_index "managers", ["name"], :name => "index_managers_on_name"

  create_table "master_fund_size", :force => true do |t|
    t.string  "fund_text", :limit => 20
    t.integer "value"
  end

  create_table "messages", :force => true do |t|
    t.string   "subject"
    t.text     "body"
    t.integer  "sender_id"
    t.integer  "manager_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "receiver_id",            :default => 0
    t.integer  "post_id",                :default => 0
    t.string   "post_type",              :default => "0"
    t.boolean  "sender_read",            :default => false
    t.boolean  "is_not_interested",      :default => false
    t.string   "message_key",            :default => "0"
    t.boolean  "sender_delete_status"
    t.boolean  "receiver_delete_status"
    t.boolean  "receiver_read"
    t.boolean  "is_interested",          :default => false
  end

  create_table "notifications", :force => true do |t|
    t.string   "name"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "options", :force => true do |t|
    t.string   "option"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.boolean  "default_check", :default => false
  end

  create_table "order_transactions", :force => true do |t|
    t.integer  "order_id"
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "plan_id"
    t.integer  "amount"
    t.string   "card_type"
    t.datetime "card_expires_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip_address"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "order_type"
    t.string   "status"
    t.string   "transaction_id"
  end

  create_table "organization_types", :force => true do |t|
    t.string   "name"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "plan_id"
  end

  create_table "pages", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_notifications", :force => true do |t|
    t.integer "user_id"
    t.string  "payment_type"
    t.text    "ipn_details"
  end

  create_table "persons", :force => true do |t|
    t.string   "name",                                :null => false
    t.string   "url",                                 :null => false
    t.integer  "manager_id",                          :null => false
    t.integer  "approver_id"
    t.datetime "approved_at"
    t.string   "status",      :default => "approved"
  end

  create_table "plans", :force => true do |t|
    t.string   "name",                                       :null => false
    t.integer  "fee"
    t.string   "duration"
    t.string   "subscription_type"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "discount"
    t.integer  "rank"
    t.integer  "no_of_views"
    t.integer  "no_of_emails"
    t.boolean  "post_secondaries_to_buy",  :default => true
    t.boolean  "post_secondaries_to_sell", :default => true
    t.integer  "no_of_replies"
    t.integer  "no_of_credits",            :default => 0
    t.boolean  "status"
  end

  create_table "profiles", :force => true do |t|
    t.string   "firstname",            :limit => 40,                     :null => false
    t.string   "lastname",             :limit => 40,                     :null => false
    t.string   "job_title",            :limit => 100
    t.string   "email",                                                  :null => false
    t.string   "organization_name",    :limit => 100
    t.string   "zip"
    t.integer  "user_id"
    t.integer  "approver_id"
    t.datetime "approved_at"
    t.boolean  "approved",                            :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by"
    t.string   "telephone"
    t.integer  "organization_type_id"
  end

  add_index "profiles", ["email"], :name => "index_profiles_on_email"
  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "questions", :force => true do |t|
    t.text     "questions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.integer  "rank"
    t.string   "question_type"
    t.boolean  "status",        :default => true
  end

  create_table "questions_roles", :id => false, :force => true do |t|
    t.integer "question_id", :null => false
    t.integer "role_id",     :null => false
  end

  create_table "questions_users", :force => true do |t|
    t.integer "question_id"
    t.integer "user_id"
  end

  add_index "questions_users", ["question_id"], :name => "index_questions_users_on_question_id"
  add_index "questions_users", ["user_id"], :name => "index_questions_users_on_user_id"

  create_table "ratings", :force => true do |t|
    t.integer  "performance"
    t.integer  "team"
    t.integer  "strategy"
    t.integer  "terms"
    t.integer  "overall"
    t.integer  "user_id",     :null => false
    t.integer  "manager_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["id"], :name => "index_ratings_on_id", :unique => true
  add_index "ratings", ["manager_id"], :name => "index_ratings_on_manager_id"
  add_index "ratings", ["user_id"], :name => "index_ratings_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "title",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id", :null => false
    t.integer "user_id", :null => false
  end

  create_table "saved_searches", :force => true do |t|
    t.string   "search_type"
    t.text     "query"
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "secondaries", :force => true do |t|
    t.string   "secondary_type",                          :null => false
    t.integer  "manager_id",                              :null => false
    t.integer  "vintage"
    t.integer  "approver_id"
    t.datetime "approved_at"
    t.string   "status",          :default => "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "expected_price",                          :null => false
    t.integer  "bite_size"
    t.string   "notes"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.string   "drawn"
    t.string   "commitment_size"
    t.integer  "fund_id"
    t.integer  "nav"
  end

  add_index "secondaries", ["id"], :name => "index_secondaries_on_id", :unique => true
  add_index "secondaries", ["manager_id"], :name => "index_secondaries_on_manager_id"
  add_index "secondaries", ["nav"], :name => "index_secondaries_on_nav"

  create_table "sectors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "session_datas", :force => true do |t|
    t.text     "data"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statistics", :force => true do |t|
    t.text     "statistic_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "statistic_to_show"
  end

  create_table "tickers", :force => true do |t|
    t.text     "ticker_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ticker_to_show"
  end

  create_table "transaction_types", :force => true do |t|
    t.string   "transaction_type"
    t.integer  "asset_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_activities", :force => true do |t|
    t.integer  "user_id",        :null => false
    t.string   "activity",       :null => false
    t.string   "regarding_type", :null => false
    t.string   "regarding_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 100,                           :null => false
    t.string   "crypted_password",          :limit => 40,                            :null => false
    t.string   "salt",                      :limit => 40,                            :null => false
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.integer  "plan_id",                                                            :null => false
    t.integer  "comment_anonymous_count"
    t.integer  "approver_id"
    t.datetime "approved_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by"
    t.integer  "manager_id"
    t.integer  "emails",                                   :default => 0
    t.integer  "replies",                                  :default => 0
    t.integer  "views",                                    :default => 0
    t.string   "email_alias",                                                        :null => false
    t.boolean  "paid",                                     :default => false
    t.string   "status",                                   :default => "unapproved"
    t.string   "activation_code"
    t.integer  "credit",                                   :default => 0
    t.integer  "first_time_login"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "paypal_profile_id"
    t.boolean  "show_user_name",                           :default => false
    t.datetime "last_user_activity"
    t.integer  "admin_fee"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "webinars", :force => true do |t|
    t.text     "title",        :null => false
    t.text     "speaker",      :null => false
    t.string   "organization"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "link",         :null => false
  end

end
