# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_210_215_085_630) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'game_tasks', force: :cascade do |t|
    t.string 'name'
    t.string 'description'
    t.string 'hint'
    t.float 'latitude'
    t.float 'longitude'
    t.string 'location'
    t.string 'state'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'route_id', null: false
    t.string 'type'
    t.json 'answers'
    t.string 'solution'
    t.bigint 'player_id'
    t.index ['player_id'], name: 'index_game_tasks_on_player_id'
    t.index ['route_id'], name: 'index_game_tasks_on_route_id'
  end

  create_table 'players', force: :cascade do |t|
    t.string 'name', null: false
    t.bigint 'user_id'
    t.bigint 'game_tasks_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'state'
    t.index ['game_tasks_id'], name: 'index_players_on_game_tasks_id'
    t.index ['user_id'], name: 'index_players_on_user_id'
  end

  create_table 'routes', force: :cascade do |t|
    t.string 'name'
    t.float 'latitude', null: false
    t.float 'longitude', null: false
    t.integer 'radius'
    t.string 'game_state'
    t.datetime 'start_time'
    t.datetime 'end_time'
    t.bigint 'game_tasks_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'player_id'
    t.index ['game_tasks_id'], name: 'index_routes_on_game_tasks_id'
    t.index ['name'], name: 'index_routes_on_name', unique: true
    t.index ['player_id'], name: 'index_routes_on_player_id'
  end

  create_table 'routes_players_associations', force: :cascade do |t|
    t.bigint 'player_id', null: false
    t.bigint 'route_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['player_id'], name: 'index_routes_players_associations_on_player_id'
    t.index ['route_id'], name: 'index_routes_players_associations_on_route_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'guest', default: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'game_tasks', 'players'
  add_foreign_key 'game_tasks', 'routes'
  add_foreign_key 'players', 'game_tasks', column: 'game_tasks_id'
  add_foreign_key 'players', 'users'
  add_foreign_key 'routes', 'game_tasks', column: 'game_tasks_id'
  add_foreign_key 'routes', 'players'
  add_foreign_key 'routes_players_associations', 'players'
  add_foreign_key 'routes_players_associations', 'routes'
end
