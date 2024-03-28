class CreateJoinTableTeamsPlays < ActiveRecord::Migration[7.0]
  def change
    create_join_table :teams, :plays do |t|
      t.index [:team_id, :play_id]
      t.index [:play_id, :team_id]
    end
  end
end
