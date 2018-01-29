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

ActiveRecord::Schema.define(version: 20180121) do

  create_table "answers", force: :cascade do |t|
    t.integer "answer"
    t.integer "pillar"
    t.integer "assessment_id"
    t.integer "question_id"
    t.index ["assessment_id"], name: "index_answers_on_assessment_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "assessment_totals", force: :cascade do |t|
    t.integer "respondents_number"
  end

  create_table "assessments", force: :cascade do |t|
    t.string "email"
    t.string "industry"
    t.string "company"
    t.string "country"
    t.boolean "completed"
  end

  create_table "questions", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "pillar"
    t.decimal "average_current", default: "0.0"
    t.decimal "average_previous", default: "0.0"
    t.decimal "sum_all_answers", default: "0.0"
  end

end
