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

ActiveRecord::Schema.define(version: 20151109214105) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_hierarchies", id: false, force: true do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "admin_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "admin_anc_desc_idx", unique: true, using: :btree
  add_index "admin_hierarchies", ["descendant_id"], name: "admin_desc_idx", using: :btree

  create_table "admins", force: true do |t|
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
    t.integer  "parent_id"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "ckeditor_assets", force: true do |t|
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

  create_table "complaints_expedient_events", force: true do |t|
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

  create_table "complaints_expedient_management_comments", force: true do |t|
    t.integer  "expedient_management_id"
    t.integer  "admin_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "complaints_expedient_management_comments", ["admin_id"], name: "index_complaints_expedient_management_comments_on_admin_id", using: :btree
  add_index "complaints_expedient_management_comments", ["expedient_management_id"], name: "comment_expedient_management_id_index", using: :btree

  create_table "complaints_expedient_management_events", force: true do |t|
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

  create_table "complaints_expedient_managements", force: true do |t|
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

  create_table "complaints_expedients", force: true do |t|
    t.string   "kind"
    t.string   "contact"
    t.string   "phone"
    t.string   "email"
    t.text     "comment"
    t.integer  "institution_id"
    t.string   "status",         default: "new"
    t.string   "correlative"
    t.datetime "received_at"
    t.datetime "confirmed_at"
    t.datetime "admitted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "complaints_expedients", ["contact"], name: "index_complaints_expedients_on_contact", using: :btree
  add_index "complaints_expedients", ["correlative"], name: "index_complaints_expedients_on_correlative", using: :btree
  add_index "complaints_expedients", ["institution_id"], name: "index_complaints_expedients_on_institution_id", using: :btree
  add_index "complaints_expedients", ["kind"], name: "index_complaints_expedients_on_kind", using: :btree
  add_index "complaints_expedients", ["status"], name: "index_complaints_expedients_on_status", using: :btree

  create_table "institutions", force: true do |t|
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

  create_table "inv_product_movements", force: true do |t|
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

  create_table "inv_products", force: true do |t|
    t.integer  "unit_id",                 null: false
    t.string   "code",       default: "", null: false
    t.string   "name",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inv_units", force: true do |t|
    t.string   "name",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inv_warehouses", force: true do |t|
    t.string   "name",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ta_articles", force: true do |t|
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
  end

  add_index "ta_articles", ["author_id"], name: "index_ta_articles_on_author_id", using: :btree

  create_table "ta_audios", force: true do |t|
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

  create_table "ta_authors", force: true do |t|
    t.string   "name"
    t.string   "twitter"
    t.integer  "admin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ta_authors", ["admin_id"], name: "index_ta_authors_on_admin_id", using: :btree

  create_table "ta_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.boolean  "inmenu",     default: false, null: false
  end

  create_table "ta_comments", force: true do |t|
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

  create_table "ta_images", force: true do |t|
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

  create_table "ta_pages", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.string   "name"
    t.text     "content"
    t.string   "slug"
    t.integer  "position",   default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ta_pages", ["slug"], name: "index_ta_pages_on_slug", unique: true, using: :btree

  create_table "ta_videos", force: true do |t|
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

  create_table "taggings", force: true do |t|
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

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "user_authorizations", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.string   "username"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
