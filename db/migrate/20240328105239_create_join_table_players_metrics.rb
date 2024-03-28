class CreateJoinTablePlayersMetrics < ActiveRecord::Migration[7.0]
  def change
    create_join_table :players, :metrics do |t|
      t.index [:player_id, :metric_id]
      t.index [:metric_id, :player_id]
    end
  end
end
