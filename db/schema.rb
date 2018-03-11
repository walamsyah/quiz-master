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

ActiveRecord::Schema.define(version: 20180310081038) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image"
    t.boolean "published", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.tsvector "search_text"
    t.index ["id"], name: "index_categories_published", where: "published"
    t.index ["search_text"], name: "index_categories_on_search_text", using: :gin
  end

  create_table "category_playings", force: :cascade do |t|
    t.integer "category_id"
    t.integer "user_id"
    t.string "category_token"
    t.integer "total_questions"
    t.integer "total_corrects"
    t.decimal "point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "question_answers", force: :cascade do |t|
    t.integer "category_id"
    t.integer "question_id"
    t.string "answer"
    t.string "category_token"
    t.boolean "is_correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "category_id", null: false
    t.text "content"
    t.string "answer"
    t.string "image"
    t.boolean "published", default: true
    t.integer "position", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id", "position"], name: "index_questions_published_position_by_category", where: "published"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_trigger("categories_before_insert_update_row_tr", :generated => true, :compatibility => 1).
      on("categories").
      before(:insert, :update) do
    <<-SQL_ACTIONS
      new.search_text :=       (
        setweight(to_tsvector('simple', replace(coalesce(new.name, ''), '''', '-')), 'A') ||
        setweight(to_tsvector('simple', replace(coalesce(new.description, ''), '''', '-')), 'B')
      );
    SQL_ACTIONS
  end

end
