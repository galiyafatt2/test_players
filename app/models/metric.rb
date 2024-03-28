class Metric < ApplicationRecord
  has_and_belongs_to_many :players
  has_and_belongs_to_many :plays

  def top_players_by_metric(team_id = nil)
    players = team_id ? Team.find(team_id).players : Player.all

    players.sort_by { |player| -player.metrics.count }.first(5)
  end
end
