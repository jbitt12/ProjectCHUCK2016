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

ActiveRecord::Schema.define(version: 20160622182123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brackets", force: true do |t|
    t.integer  "tournament_id"
    t.string   "gender"
    t.integer  "min_age"
    t.integer  "max_age"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "max_students"
    t.boolean  "active"
    t.string   "name"
  end

  create_table "documents", force: true do |t|
    t.string   "document"
    t.string   "doc_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "student_id"
  end

  create_table "games", force: true do |t|
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guardians", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "cell_phone"
    t.boolean  "receives_text_msgs"
    t.boolean  "active"
    t.boolean  "is_emergency_contact"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "households", force: true do |t|
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "home_phone"
    t.string   "county"
    t.boolean  "active"
    t.boolean  "has_proof_of_insurance"
    t.string   "insurance_provider"
    t.string   "insurance_policy_no"
    t.string   "family_physician"
    t.string   "physician_phone"
    t.string   "proof_of_insurance"
    t.boolean  "poi_checkoff"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "guardian_id"
  end

  create_table "registrations", force: true do |t|
    t.integer  "student_id"
    t.integer  "bracket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
  end

  create_table "roster_spots", force: true do |t|
    t.integer  "team_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "jersey_number"
    t.boolean  "active"
  end

  create_table "schools", force: true do |t|
    t.string   "name"
    t.string   "district"
    t.string   "county"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.integer  "household_id"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "dob"
    t.string   "cell_phone"
    t.string   "email"
    t.integer  "grade"
    t.string   "gender"
    t.text     "allergies"
    t.text     "medications"
    t.boolean  "active"
    t.integer  "school_id"
    t.string   "jersey_size"
    t.string   "gpa"
    t.integer  "past_participation"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "instagram"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "birth_certificate"
    t.string   "emergency_contact_relation"
    t.string   "school"
    t.string   "district"
    t.boolean  "poi_checkoff"
    t.boolean  "bc_checkoff"
    t.boolean  "rc_checkoff"
    t.boolean  "phy_checkoff"
  end

  create_table "team_games", force: true do |t|
    t.integer  "game_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score"
  end

  create_table "teams", force: true do |t|
    t.integer  "bracket_id"
    t.string   "name"
    t.integer  "max_students"
    t.integer  "num_wins"
    t.integer  "num_losses"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tournaments", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
    t.boolean  "active"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "role"
    t.string   "email"
    t.boolean  "active"
    t.string   "password_digest"
    t.date     "active_after"
    t.string   "password_reset_token"
    t.date     "password_reset_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "volunteers", force: true do |t|
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "cell_phone"
    t.boolean  "receives_text_msgs"
    t.boolean  "active"
    t.string   "role"
    t.date     "date"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "day_phone"
    t.integer  "years_with_proj_chuck"
    t.string   "position"
    t.string   "team_coached"
    t.string   "child_name"
    t.string   "shirt_size"
    t.string   "clearance_copy"
    t.text     "not_available"
    t.text     "two_skills"
    t.text     "suggestions"
    t.string   "volunteer_sign"
    t.date     "volunteer_sign_date"
    t.boolean  "act33_clearance"
    t.boolean  "act34_clearance"
    t.boolean  "act153_clearance"
    t.date     "dob"
    t.integer  "user_id"
    t.string   "gender"
    t.string   "age_range"
  end

end
