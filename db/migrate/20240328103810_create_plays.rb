class CreatePlays < ActiveRecord::Migration[7.0]
  def change
    create_table :plays do |t|
      t.date :date

      t.timestamps
    end
  end
end
