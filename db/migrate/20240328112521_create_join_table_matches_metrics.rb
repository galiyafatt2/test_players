class CreateJoinTableMatchesMetrics < ActiveRecord::Migration[7.0]
  def change
    create_join_table :matches, :metrics do |t|
      t.index [:match_id, :metric_id]
      t.index [:metric_id, :match_id]
    end
  end
end
