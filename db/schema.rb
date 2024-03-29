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

ActiveRecord::Schema.define(version: 20170828175536) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "admin_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "admin_anc_desc_idx", unique: true, using: :btree
  add_index "admin_hierarchies", ["descendant_id"], name: "admin_desc_idx", using: :btree

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "role_id"
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.text     "tokens"
    t.boolean  "is_active",              default: true
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  add_index "admins", ["role_id"], name: "index_admins_on_role_id", using: :btree

  create_table "agreements_user_peace_signatures", force: :cascade do |t|
    t.string   "name"
    t.string   "country"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "state"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "complaints_assets", force: :cascade do |t|
    t.integer  "admin_id"
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "complaints_assets", ["admin_id"], name: "index_complaints_assets_on_admin_id", using: :btree

  create_table "complaints_assets_expedient_management_comments", id: false, force: :cascade do |t|
    t.integer "asset_id"
    t.integer "expedient_management_comment_id"
  end

  add_index "complaints_assets_expedient_management_comments", ["asset_id", "expedient_management_comment_id"], name: "asset_expedient_management_comment", using: :btree
  add_index "complaints_assets_expedient_management_comments", ["expedient_management_comment_id", "asset_id"], name: "expedient_management_comment_asset", using: :btree

  create_table "complaints_assets_expedient_managements", id: false, force: :cascade do |t|
    t.integer "asset_id"
    t.integer "expedient_management_id"
  end

  add_index "complaints_assets_expedient_managements", ["asset_id", "expedient_management_id"], name: "asset_expedient_management", using: :btree
  add_index "complaints_assets_expedient_managements", ["expedient_management_id", "asset_id"], name: "expedient_management_asset", using: :btree

  create_table "complaints_expedient_events", force: :cascade do |t|
    t.string   "status",        default: "process"
    t.integer  "expedient_id"
    t.integer  "admin_id"
    t.datetime "start_at"
    t.text     "justification"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "complaints_expedient_events", ["admin_id"], name: "index_complaints_expedient_events_on_admin_id", using: :btree
  add_index "complaints_expedient_events", ["expedient_id"], name: "index_complaints_expedient_events_on_expedient_id", using: :btree

  create_table "complaints_expedient_management_comments", force: :cascade do |t|
    t.integer  "expedient_management_id"
    t.integer  "admin_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "complaints_expedient_management_comments", ["admin_id"], name: "index_complaints_expedient_management_comments_on_admin_id", using: :btree
  add_index "complaints_expedient_management_comments", ["expedient_management_id"], name: "comment_expedient_management_id_index", using: :btree

  create_table "complaints_expedient_management_events", force: :cascade do |t|
    t.string   "status",                  default: "process"
    t.integer  "expedient_management_id"
    t.integer  "admin_id"
    t.datetime "start_at"
    t.text     "justification"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "complaints_expedient_management_events", ["admin_id"], name: "index_complaints_expedient_management_events_on_admin_id", using: :btree
  add_index "complaints_expedient_management_events", ["expedient_management_id"], name: "expedient_management_id_index", using: :btree

  create_table "complaints_expedient_managements", force: :cascade do |t|
    t.integer  "expedient_id"
    t.integer  "admin_id"
    t.string   "kind"
    t.string   "status",       default: "new"
    t.text     "comment"
    t.integer  "assigned_ids", default: [],    array: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "weight",       default: 1
    t.string   "closed_as"
  end

  add_index "complaints_expedient_managements", ["admin_id"], name: "index_complaints_expedient_managements_on_admin_id", using: :btree
  add_index "complaints_expedient_managements", ["expedient_id"], name: "index_complaints_expedient_managements_on_expedient_id", using: :btree

  create_table "complaints_expedients", force: :cascade do |t|
    t.string   "kind"
    t.string   "contact"
    t.string   "phone"
    t.string   "email"
    t.text     "comment"
    t.integer  "institution_id"
    t.string   "status",             default: "new"
    t.string   "correlative"
    t.integer  "admin_id"
    t.datetime "received_at"
    t.datetime "confirmed_at"
    t.datetime "admitted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.integer  "expedient_id"
    t.string   "reference_code",     default: ""
  end

  add_index "complaints_expedients", ["contact"], name: "index_complaints_expedients_on_contact", using: :btree
  add_index "complaints_expedients", ["correlative"], name: "index_complaints_expedients_on_correlative", using: :btree
  add_index "complaints_expedients", ["expedient_id"], name: "index_complaints_expedients_on_expedient_id", using: :btree
  add_index "complaints_expedients", ["institution_id"], name: "index_complaints_expedients_on_institution_id", using: :btree
  add_index "complaints_expedients", ["kind"], name: "index_complaints_expedients_on_kind", using: :btree
  add_index "complaints_expedients", ["status"], name: "index_complaints_expedients_on_status", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employments_areas", force: :cascade do |t|
    t.integer  "factor_score_id"
    t.text     "name"
    t.integer  "order"
    t.decimal  "score",           precision: 18, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                                   default: true
  end

  add_index "employments_areas", ["factor_score_id"], name: "index_employments_areas_on_factor_score_id", using: :btree

  create_table "employments_countries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employments_disability_certifications", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employments_disability_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employments_plaza_contracts", force: :cascade do |t|
    t.integer  "plaza_id"
    t.string   "name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     default: true
  end

  add_index "employments_plaza_contracts", ["plaza_id"], name: "index_employments_plaza_contracts_on_plaza_id", using: :btree

  create_table "employments_plaza_degrees", force: :cascade do |t|
    t.integer  "plaza_id"
    t.string   "gra_code"
    t.string   "gra_name"
    t.string   "req_code"
    t.string   "req_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     default: true
  end

  add_index "employments_plaza_degrees", ["plaza_id"], name: "index_employments_plaza_degrees_on_plaza_id", using: :btree

  create_table "employments_plaza_experiences", force: :cascade do |t|
    t.integer  "plaza_id"
    t.string   "exp_code"
    t.string   "exp_name"
    t.string   "exp_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",          default: true
  end

  add_index "employments_plaza_experiences", ["plaza_id"], name: "index_employments_plaza_experiences_on_plaza_id", using: :btree

  create_table "employments_plaza_factors", force: :cascade do |t|
    t.string   "name"
    t.integer  "factor_score_id"
    t.integer  "plaza_id"
    t.decimal  "minimum_score",   precision: 18, scale: 2
    t.decimal  "maximum_score",   precision: 18, scale: 2
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "factor_id"
    t.boolean  "active",                                   default: true
  end

  add_index "employments_plaza_factors", ["factor_score_id"], name: "index_employments_plaza_factors_on_factor_score_id", using: :btree
  add_index "employments_plaza_factors", ["plaza_id"], name: "index_employments_plaza_factors_on_plaza_id", using: :btree

  create_table "employments_plaza_languages", force: :cascade do |t|
    t.integer  "plaza_id"
    t.string   "idi_code"
    t.string   "idi_name"
    t.string   "req_code"
    t.string   "req_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     default: true
  end

  add_index "employments_plaza_languages", ["plaza_id"], name: "index_employments_plaza_languages_on_plaza_id", using: :btree

  create_table "employments_plaza_skills", force: :cascade do |t|
    t.integer  "plaza_id"
    t.text     "name"
    t.string   "req_code"
    t.string   "req_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     default: true
  end

  add_index "employments_plaza_skills", ["plaza_id"], name: "index_employments_plaza_skills_on_plaza_id", using: :btree

  create_table "employments_plaza_specialties", force: :cascade do |t|
    t.integer  "plaza_id"
    t.string   "esp_code"
    t.string   "esp_name"
    t.string   "req_code"
    t.string   "req_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     default: true
  end

  add_index "employments_plaza_specialties", ["plaza_id"], name: "index_employments_plaza_specialties_on_plaza_id", using: :btree

  create_table "employments_plazas", force: :cascade do |t|
    t.string   "identifier"
    t.string   "post_name"
    t.string   "convocation_id"
    t.string   "convocation_name"
    t.string   "institution_id"
    t.string   "institution_name"
    t.string   "institution_code"
    t.boolean  "autonomous",                                       default: false
    t.integer  "plaza_id"
    t.integer  "plaza_state_id"
    t.string   "plaza_state"
    t.integer  "vacancies",                                        default: 1
    t.decimal  "salary",                  precision: 18, scale: 2
    t.datetime "opening_registration"
    t.datetime "closing_registration"
    t.string   "inspto_code"
    t.string   "organization_department"
    t.text     "mission"
    t.text     "function"
    t.text     "result"
    t.text     "frame"
    t.text     "description"
    t.string   "email"
    t.text     "address"
    t.string   "phone"
    t.text     "comment"
    t.datetime "created_date"
    t.datetime "updated_date"
    t.string   "created_user"
    t.string   "updated_user"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                                           default: true
    t.string   "location"
    t.string   "contract_type"
    t.integer  "participants_number"
    t.text     "closing_comment"
    t.integer  "stpp_apply_counter",                               default: 0
    t.integer  "spta_apply_counter",                               default: 0
  end

  add_index "employments_plazas", ["plaza_id"], name: "index_employments_plazas_on_plaza_id", using: :btree

  create_table "employments_postulant_comments", force: :cascade do |t|
    t.boolean  "active",       default: true
    t.text     "comment"
    t.date     "commented_at"
    t.integer  "technical_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "postulant_id"
  end

  add_index "employments_postulant_comments", ["postulant_id"], name: "index_employments_postulant_comments_on_postulant_id", using: :btree

  create_table "employments_postulant_evaluations", force: :cascade do |t|
    t.boolean  "active",             default: true
    t.integer  "postulant_skill_id"
    t.integer  "configuration_id"
    t.integer  "factor_id"
    t.text     "name"
    t.float    "weight"
    t.float    "calification"
    t.float    "assigned_score"
    t.float    "obtained_score"
    t.integer  "created_user"
    t.datetime "created_date"
    t.integer  "updated_user"
    t.datetime "updated_date"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "postulant_id"
  end

  add_index "employments_postulant_evaluations", ["postulant_id"], name: "index_employments_postulant_evaluations_on_postulant_id", using: :btree

  create_table "employments_postulants", force: :cascade do |t|
    t.integer  "stpp_id"
    t.integer  "plaza_id"
    t.string   "identifier"
    t.string   "postulant_code"
    t.integer  "postulant_state_competition"
    t.boolean  "qualified"
    t.boolean  "vb_training"
    t.boolean  "vb_skills"
    t.boolean  "vb_experiences"
    t.integer  "created_user"
    t.date     "created_date"
    t.integer  "updated_user"
    t.date     "updated_date"
    t.boolean  "active",                      default: true
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "employments_specialties", force: :cascade do |t|
    t.string   "esp_code"
    t.string   "esp_name"
    t.string   "gra_code"
    t.string   "gra_name"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "priority",   default: 0
    t.boolean  "active",     default: true
  end

  create_table "employments_user_disabilities", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "disability_type_id"
    t.integer  "disability_certification_id"
    t.integer  "user_created"
    t.integer  "user_edited"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employments_user_disabilities", ["user_id"], name: "index_employments_user_disabilities_on_user_id", using: :btree

  create_table "employments_user_languages", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "read"
    t.integer  "write"
    t.integer  "speak"
    t.integer  "user_created"
    t.integer  "user_edited"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employments_user_languages", ["user_id"], name: "index_employments_user_languages_on_user_id", using: :btree

  create_table "employments_user_postulations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "plaza_id"
    t.string   "code"
    t.string   "response_code"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "employments_user_references", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "charge"
    t.string   "address"
    t.string   "phone"
    t.integer  "kind"
    t.integer  "user_created"
    t.integer  "user_edited"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employments_user_references", ["user_id"], name: "index_employments_user_references_on_user_id", using: :btree

  create_table "employments_user_skills", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "employments_user_skills", ["user_id"], name: "index_employments_user_skills_on_user_id", using: :btree

  create_table "employments_user_specialties", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "country_id"
    t.string   "name"
    t.string   "esp_code"
    t.string   "esp_name"
    t.string   "gra_code"
    t.string   "institution_name"
    t.string   "certificate_file_name"
    t.string   "certificate_content_type"
    t.integer  "certificate_file_size"
    t.datetime "certificate_updated_at"
    t.date     "start_at"
    t.date     "end_at"
    t.integer  "user_created"
    t.integer  "user_edited"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employments_user_specialties", ["user_id"], name: "index_employments_user_specialties_on_user_id", using: :btree

  create_table "employments_user_trainings", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "institution_name"
    t.string   "name"
    t.text     "description"
    t.string   "place"
    t.string   "duration"
    t.integer  "year"
    t.integer  "user_created"
    t.integer  "user_edited"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employments_user_trainings", ["user_id"], name: "index_employments_user_trainings_on_user_id", using: :btree

  create_table "employments_user_work_experiences", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "sector"
    t.integer  "country_id"
    t.string   "institution_name"
    t.string   "charge"
    t.text     "description"
    t.date     "start_at"
    t.date     "end_at"
    t.integer  "active"
    t.integer  "user_created"
    t.integer  "user_edited"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employments_user_work_experiences", ["user_id"], name: "index_employments_user_work_experiences_on_user_id", using: :btree

  create_table "forums_actors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forums_entries", force: :cascade do |t|
    t.string   "kind"
    t.integer  "theme_id"
    t.integer  "organization_id"
    t.integer  "actor_id"
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.date     "entry_at"
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.integer  "admin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "forums_entries", ["actor_id"], name: "index_forums_entries_on_actor_id", using: :btree
  add_index "forums_entries", ["admin_id"], name: "index_forums_entries_on_admin_id", using: :btree
  add_index "forums_entries", ["kind"], name: "index_forums_entries_on_kind", using: :btree
  add_index "forums_entries", ["organization_id"], name: "index_forums_entries_on_organization_id", using: :btree
  add_index "forums_entries", ["slug"], name: "index_forums_entries_on_slug", using: :btree
  add_index "forums_entries", ["theme_id"], name: "index_forums_entries_on_theme_id", using: :btree

  create_table "forums_organizations", force: :cascade do |t|
    t.string   "name"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "kind"
  end

  add_index "forums_organizations", ["kind"], name: "index_forums_organizations_on_kind", using: :btree

  create_table "forums_postures", force: :cascade do |t|
    t.integer  "theme_id"
    t.integer  "organization_id"
    t.integer  "actor_id"
    t.integer  "entry_id"
    t.integer  "admin_id"
    t.text     "quote"
    t.date     "quoted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
  end

  add_index "forums_postures", ["actor_id"], name: "index_forums_postures_on_actor_id", using: :btree
  add_index "forums_postures", ["admin_id"], name: "index_forums_postures_on_admin_id", using: :btree
  add_index "forums_postures", ["entry_id"], name: "index_forums_postures_on_entry_id", using: :btree
  add_index "forums_postures", ["organization_id"], name: "index_forums_postures_on_organization_id", using: :btree
  add_index "forums_postures", ["theme_id"], name: "index_forums_postures_on_theme_id", using: :btree

  create_table "forums_themes", force: :cascade do |t|
    t.boolean  "active",                 default: false
    t.integer  "priority",               default: 0
    t.string   "name"
    t.string   "video_url"
    t.text     "description"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.boolean  "main",                   default: false
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "actors_description"
    t.text     "citizens_description"
    t.text     "historical_description"
    t.string   "twitter_id"
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.integer  "asset_downloads",        default: 0
    t.string   "asset_title"
    t.string   "hashtag"
  end

  add_index "forums_themes", ["slug"], name: "index_forums_themes_on_slug", using: :btree

  create_table "ind_categories", force: :cascade do |t|
    t.string   "name"
    t.string   "color"
    t.string   "description"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "ind_note_kinds", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ind_notes", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "title"
    t.string   "slug"
    t.text     "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "note_kind_id"
  end

  add_index "ind_notes", ["category_id"], name: "index_ind_notes_on_category_id", using: :btree

  create_table "ind_sn_note_images", force: :cascade do |t|
    t.integer  "sn_note_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "ind_sn_note_images", ["sn_note_id"], name: "index_ind_sn_note_images_on_sn_note_id", using: :btree

  create_table "ind_sn_notes", force: :cascade do |t|
    t.integer  "note_id"
    t.string   "description"
    t.integer  "day"
    t.integer  "hour"
    t.integer  "minute"
    t.integer  "active"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "ind_sn_notes", ["note_id"], name: "index_ind_sn_notes_on_note_id", using: :btree

  create_table "institutions", force: :cascade do |t|
    t.string   "name"
    t.integer  "institution_type_id"
    t.string   "acronym"
    t.boolean  "ranked"
    t.boolean  "at_complaints"
    t.string   "slug"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "header_file_name"
    t.string   "header_content_type"
    t.integer  "header_file_size"
    t.datetime "header_updated_at"
    t.boolean  "at_information_requests"
    t.boolean  "accepts_online_information_requests"
    t.integer  "information_standard_category_id"
    t.integer  "information_request_correlative"
    t.string   "transparency_external_portal_url"
    t.boolean  "highlight_events"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "institutions", ["information_standard_category_id"], name: "index_institutions_on_information_standard_category_id", using: :btree
  add_index "institutions", ["institution_type_id"], name: "index_institutions_on_institution_type_id", using: :btree
  add_index "institutions", ["slug"], name: "index_institutions_on_slug", using: :btree

  create_table "inv_product_movements", force: :cascade do |t|
    t.integer  "kind",           default: 0, null: false
    t.integer  "cause",          default: 0, null: false
    t.text     "comments"
    t.integer  "product_id",                 null: false
    t.integer  "warehouse_id",               null: false
    t.integer  "quantity",       default: 0, null: false
    t.integer  "admin_id",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "warehouse_from"
  end

  create_table "inv_products", force: :cascade do |t|
    t.integer  "unit_id",                 null: false
    t.string   "code",       default: "", null: false
    t.string   "name",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inv_units", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inv_warehouses", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "msg_groups", force: :cascade do |t|
    t.string   "name"
    t.text     "contacts"
    t.integer  "admin_id"
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "msg_groups", ["admin_id"], name: "index_msg_groups_on_admin_id", using: :btree
  add_index "msg_groups", ["name"], name: "index_msg_groups_on_name", using: :btree

  create_table "msg_messages", force: :cascade do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ofcia_payroll_economic_activities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "sector",     default: 0
  end

  create_table "ofcia_payroll_employment_indicators", force: :cascade do |t|
    t.integer  "year"
    t.integer  "occupied"
    t.integer  "unoccupied"
    t.integer  "inactive"
    t.integer  "pea"
    t.integer  "pet"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ofcia_payroll_patrons", force: :cascade do |t|
    t.string   "name"
    t.string   "nit"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "payroll_economic_activity_id"
    t.integer  "payroll_patron_id"
  end

  add_index "ofcia_payroll_patrons", ["payroll_patron_id"], name: "index_ofcia_payroll_patrons_on_payroll_patron_id", using: :btree

  create_table "ofcia_payrolls", force: :cascade do |t|
    t.string   "period"
    t.date     "period_date"
    t.integer  "payroll_patron_id"
    t.integer  "total_up",                                    default: 0
    t.decimal  "amount_up",          precision: 12, scale: 2, default: 0.0
    t.integer  "total_down",                                  default: 0
    t.decimal  "amount_down",        precision: 12, scale: 2
    t.integer  "total_pensioned",                             default: 0
    t.integer  "total_contributors",                          default: 0
    t.integer  "total",                                       default: 0
    t.decimal  "amount_total",       precision: 12, scale: 2
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
  end

  add_index "ofcia_payrolls", ["payroll_patron_id"], name: "index_ofcia_payrolls_on_payroll_patron_id", using: :btree
  add_index "ofcia_payrolls", ["period_date"], name: "index_ofcia_payrolls_on_period_date", using: :btree

  create_table "paa_financial_sources", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paa_holders", force: :cascade do |t|
  end

  create_table "paa_savings", force: :cascade do |t|
    t.string   "state",                                                                      default: "draft"
    t.integer  "institution_id"
    t.date     "start_at"
    t.date     "end_at"
    t.integer  "financial_source_id"
    t.integer  "admin_id"
    t.decimal  "remuneration",                                      precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "food_products",                                     precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "textile_products",                                  precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "fuels_products",                                    precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "paper_products",                                    precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "basic_services",                                    precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "social_services",                                   precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "passages",                                          precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "training_services",                                 precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "ad_services",                                       precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "financial_expenses",                                precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "transfers",                                         precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "investments",                                       precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "remuneration_audited",                              precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "food_products_audited",                             precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "textile_products_audited",                          precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "fuels_products_audited",                            precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "paper_products_audited",                            precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "basic_services_audited",                            precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "social_services_audited",                           precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "passages_audited",                                  precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "training_services_audited",                         precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "ad_services_audited",                               precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "financial_expenses_audited",                        precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "transfers_audited",                                 precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "investments_audited",                               precision: 18, scale: 2, default: 0.0,     null: false
    t.text     "remuneration_explanation"
    t.text     "remuneration_actions"
    t.text     "food_products_explanation"
    t.text     "food_products_actions"
    t.text     "textile_products_explanation"
    t.text     "textile_products_actions"
    t.text     "fuels_products_explanation"
    t.text     "fuels_products_actions"
    t.text     "paper_products_explanation"
    t.text     "paper_products_actions"
    t.text     "basic_services_explanation"
    t.text     "basic_services_actions"
    t.text     "social_services_explanation"
    t.text     "social_services_actions"
    t.text     "passages_explanation"
    t.text     "passages_actions"
    t.text     "training_services_explanation"
    t.text     "training_services_actions"
    t.text     "ad_services_explanation"
    t.text     "ad_services_actions"
    t.text     "financial_expenses_explanation"
    t.text     "financial_expenses_actions"
    t.text     "transfers_explanation"
    t.text     "transfers_actions"
    t.text     "investments_explanation"
    t.text     "investments_actions"
    t.text     "remuneration_audit_explanation"
    t.text     "food_products_audit_explanation"
    t.text     "textile_products_audit_explanation"
    t.text     "fuels_products_audit_explanation"
    t.text     "paper_products_audit_explanation"
    t.text     "basic_services_audit_explanation"
    t.text     "social_services_audit_explanation"
    t.text     "passages_audit_explanation"
    t.text     "training_services_audit_explanation"
    t.text     "ad_services_audit_explanation"
    t.text     "financial_expenses_audit_explanation"
    t.text     "transfers_audit_explanation"
    t.text     "investments_audit_explanation"
    t.integer  "auditor_id"
    t.datetime "audited_at"
    t.text     "audit_comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "cat_remuneration_frozen",                           precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "cat_procurement_of_goods_and_services_frozen",      precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "cat_financial_expenses_and_other_frozen",           precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "cat_current_transfers_frozen",                      precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "cat_investment_in_fixed_assets_frozen",             precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "cat_remuneration_rescheduled",                      precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "cat_procurement_of_goods_and_services_rescheduled", precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "cat_financial_expenses_and_other_rescheduled",      precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "cat_current_transfers_rescheduled",                 precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "cat_investment_in_fixed_assets_rescheduled",        precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "cat_procurement_of_services_frozen",                precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "cat_procurement_of_services_rescheduled",           precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "cat_procurement_of_goods_frozen",                   precision: 18, scale: 2, default: 0.0,     null: false
    t.decimal  "cat_procurement_of_goods_rescheduled",              precision: 18, scale: 2, default: 0.0,     null: false
    t.integer  "holder_id"
  end

  add_index "paa_savings", ["admin_id"], name: "index_paa_savings_on_admin_id", using: :btree
  add_index "paa_savings", ["auditor_id"], name: "index_paa_savings_on_auditor_id", using: :btree
  add_index "paa_savings", ["financial_source_id"], name: "index_paa_savings_on_financial_source_id", using: :btree
  add_index "paa_savings", ["institution_id"], name: "index_paa_savings_on_institution_id", using: :btree
  add_index "paa_savings", ["state"], name: "index_paa_savings_on_state", using: :btree

  create_table "pensions_subscribers", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "req_product_requirements", force: :cascade do |t|
    t.integer  "requirement_id",             null: false
    t.integer  "product_id",                 null: false
    t.integer  "quantity",       default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "req_requirements", force: :cascade do |t|
    t.string   "code",       default: "", null: false
    t.integer  "status",     default: 0,  null: false
    t.integer  "admin_id",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",                        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "activities",     default: [],              array: true
    t.integer  "institution_id"
  end

  add_index "roles", ["institution_id"], name: "index_roles_on_institution_id", using: :btree

  create_table "serv_meets", force: :cascade do |t|
    t.integer  "room_id"
    t.integer  "admin_id"
    t.integer  "audience_type",                      null: false
    t.integer  "assistants_number",                  null: false
    t.boolean  "require_assistance", default: false, null: false
    t.text     "observations"
    t.string   "title",              default: "",    null: false
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "serv_rooms", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ta_articles", force: :cascade do |t|
    t.string   "title"
    t.text     "summary"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.integer  "author_id"
    t.string   "slug"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "published_at"
    t.integer  "status",             default: 0,     null: false
    t.string   "pretitle",           default: "",    null: false
    t.boolean  "featured",           default: false, null: false
    t.boolean  "front"
    t.integer  "layout",             default: 0,     null: false
    t.string   "video_url",          default: "",    null: false
    t.string   "audio_url",          default: "",    null: false
    t.integer  "image_width",        default: 0,     null: false
    t.integer  "image_height",       default: 0,     null: false
  end

  add_index "ta_articles", ["author_id"], name: "index_ta_articles_on_author_id", using: :btree

  create_table "ta_audios", force: :cascade do |t|
    t.integer  "priority"
    t.integer  "article_id"
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ta_audios", ["article_id"], name: "index_ta_audios_on_article_id", using: :btree

  create_table "ta_authors", force: :cascade do |t|
    t.string   "name"
    t.string   "twitter"
    t.integer  "admin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ta_authors", ["admin_id"], name: "index_ta_authors_on_admin_id", using: :btree

  create_table "ta_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.boolean  "inmenu",     default: false, null: false
  end

  create_table "ta_comments", force: :cascade do |t|
    t.integer  "article_id"
    t.integer  "comment_id"
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.integer  "status",     default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ta_comments", ["article_id"], name: "index_ta_comments_on_article_id", using: :btree
  add_index "ta_comments", ["comment_id"], name: "index_ta_comments_on_comment_id", using: :btree

  create_table "ta_images", force: :cascade do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "priority",           default: 0, null: false
    t.text     "description"
    t.integer  "image_width",        default: 0, null: false
    t.integer  "image_height",       default: 0, null: false
  end

  create_table "ta_pages", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.string   "name"
    t.text     "content"
    t.string   "slug"
    t.integer  "position",   default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ta_pages", ["slug"], name: "index_ta_pages_on_slug", unique: true, using: :btree

  create_table "ta_videos", force: :cascade do |t|
    t.integer  "priority"
    t.integer  "article_id"
    t.string   "title"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ta_videos", ["article_id"], name: "index_ta_videos_on_article_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tracker_articles", force: :cascade do |t|
    t.string   "name",                      null: false
    t.text     "description",  default: "", null: false
    t.datetime "publish_date",              null: false
    t.integer  "author_id"
    t.integer  "status_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "tracker_articles", ["author_id"], name: "index_tracker_articles_on_author_id", using: :btree
  add_index "tracker_articles", ["status_id"], name: "index_tracker_articles_on_status_id", using: :btree

  create_table "tracker_authors", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.string   "email",      default: "", null: false
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "tracker_authors", ["user_id"], name: "index_tracker_authors_on_user_id", using: :btree

  create_table "tracker_statuses", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tracker_statuses", ["status_id"], name: "index_tracker_statuses_on_status_id", using: :btree

  create_table "user_authorizations", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.string   "username"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "name"
    t.string   "gender"
    t.date     "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id"
    t.string   "last_name"
    t.string   "phone"
    t.string   "alt_phone"
    t.string   "document_type"
    t.string   "document_number"
    t.string   "tax_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "user_created"
    t.integer  "user_edited"
    t.string   "unknown_code"
    t.string   "username"
    t.string   "treatment"
    t.text     "address"
    t.integer  "stpp_id"
    t.integer  "response_code"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["country_id"], name: "index_users_on_country_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "ver_inscriptions", force: :cascade do |t|
    t.string   "location"
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "ofcia_payroll_patrons", "ofcia_payroll_economic_activities", column: "payroll_economic_activity_id"
  add_foreign_key "ofcia_payrolls", "ofcia_payroll_patrons", column: "payroll_patron_id"
end
