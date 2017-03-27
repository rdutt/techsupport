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

ActiveRecord::Schema.define(:version => 20151019182726) do

  create_table "tickets", :force => true do |t|
    t.string   "platform"
    t.string   "application"
    t.string   "member1"
    t.string   "member2"
    t.text     "error_message"
    t.text     "description"
    t.string   "priority"
    t.string   "from_email"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "subject"
    t.string   "from_name"
    t.integer  "zendesk_ticket_id"
    t.integer  "user_id"
    t.string   "problem_url"
    t.integer  "consultation_id"
    t.string   "web_browser"
    t.string   "image"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
