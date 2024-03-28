class CreateJoinTablePlaysMetrics < ActiveRecord::Migration[7.0]
  def change
    create_join_table :plays, :metrics do |t|
      t.index [:play_id, :metric_id]
      t.index [:metric_id, :play_id]
    end
  end
end
