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

ActiveRecord::Schema.define(:version => 20110704041255) do

  create_table "definitions", :force => true do |t|
    t.string   "content"
    t.integer  "word_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "definitions", ["created_at"], :name => "index_definitions_on_created_at"
  add_index "definitions", ["word_id"], :name => "index_definitions_on_word_id"

  create_table "examples", :force => true do |t|
    t.string   "content"
    t.integer  "word_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "examples", ["created_at"], :name => "index_examples_on_created_at"
  add_index "examples", ["word_id"], :name => "index_examples_on_word_id"

  create_table "explanations", :force => true do |t|
    t.string   "content"
    t.string   "word_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "explanations", ["created_at"], :name => "index_explanations_on_created_at"
  add_index "explanations", ["word_id"], :name => "index_explanations_on_word_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  create_table "words", :force => true do |t|
    t.string   "word"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "words", ["word"], :name => "index_words_on_word", :unique => true

end
