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

ActiveRecord::Schema[7.0].define(version: 2024_03_28_154219) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "metrics", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "metrics_players", id: false, force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "metric_id", null: false
    t.index ["metric_id", "player_id"], name: "index_metrics_players_on_metric_id_and_player_id"
    t.index ["player_id", "metric_id"], name: "index_metrics_players_on_player_id_and_metric_id"
  end

  create_table "metrics_plays", id: false, force: :cascade do |t|
    t.bigint "play_id", null: false
    t.bigint "metric_id", null: false
    t.index ["metric_id", "play_id"], name: "index_metrics_plays_on_metric_id_and_play_id"
    t.index ["play_id", "metric_id"], name: "index_metrics_plays_on_play_id_and_metric_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "plays", force: :cascade do |t|
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plays_teams", id: false, force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "play_id", null: false
    t.index ["play_id", "team_id"], name: "index_plays_teams_on_play_id_and_team_id"
    t.index ["team_id", "play_id"], name: "index_plays_teams_on_team_id_and_play_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
