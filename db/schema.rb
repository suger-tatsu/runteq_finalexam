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

ActiveRecord::Schema[8.0].define(version: 2025_06_05_185636) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "group_assignment_students", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "group_assignment_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_assignment_id"], name: "index_group_assignment_students_on_group_assignment_id"
    t.index ["group_id"], name: "index_group_assignment_students_on_group_id"
    t.index ["student_id"], name: "index_group_assignment_students_on_student_id"
  end

  create_table "group_assignments", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "ability_selection"
    t.integer "group_count"
    t.string "public_token"
    t.string "public_password_digest"
    t.boolean "public_enabled", default: false
    t.index ["public_token"], name: "index_group_assignments_on_public_token", unique: true
    t.index ["teacher_id"], name: "index_group_assignments_on_teacher_id"
  end

  create_table "group_skills", force: :cascade do |t|
    t.bigint "group_id"
    t.string "skill"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_skills_on_group_id"
  end

  create_table "group_students", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_students_on_group_id"
    t.index ["student_id"], name: "index_group_students_on_student_id"
  end

  create_table "groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.bigint "group_assignment_id"
    t.index ["group_assignment_id"], name: "index_groups_on_group_assignment_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "teacher_id"
    t.index ["name", "teacher_id"], name: "index_skills_on_name_and_teacher_id", unique: true
  end

  create_table "student_skills", force: :cascade do |t|
    t.integer "student_id"
    t.integer "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.integer "student_id"
    t.string "name"
    t.string "gender"
    t.float "height"
    t.float "weight"
    t.integer "athletic_ability"
    t.integer "leadership"
    t.integer "cooperation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "science"
    t.integer "humanities"
    t.integer "teacher_id"
    t.index ["name", "teacher_id"], name: "index_students_on_name_and_teacher_id", unique: true
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.index ["email"], name: "index_teachers_on_email"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "group_assignment_students", "group_assignments"
  add_foreign_key "group_assignment_students", "groups"
  add_foreign_key "group_assignment_students", "students"
  add_foreign_key "group_assignments", "teachers"
  add_foreign_key "group_skills", "groups"
  add_foreign_key "group_students", "groups"
  add_foreign_key "group_students", "students"
  add_foreign_key "groups", "group_assignments"
end
