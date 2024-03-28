class Player < ApplicationRecord
  belongs_to :team

  has_and_belongs_to_many :metrics

  def mark_metric_in_match(metric_id, match_id)
    metric = Metric.find(metric_id)
    match = Match.find(match_id)
    if match.teams.include?(team)
      metrics << metric
    else
      raise "Player's team doesn't participate in the match"
    end
  end

  def executed_metric_in_last_five_matches?(metric_id)
    team_matches = team.matches.order(date: :desc).limit(5)
    team_matches.each do |match|
      return true if match.teams.include?(team) && metrics.exists?(id: metric_id)
    end
    false
  end

  def self.top_players_by_metric(metric_id, team_id = nil)
    if team_id
      team = Team.find(team_id)
      players = team.players.includes(:metrics).where(metrics: { id: metric_id }).references(:metrics)
    else
      players = Player.includes(:metrics).where(metrics: { id: metric_id }).references(:metrics)
    end
    players.sort_by { |player| -player.metrics.count }.first(5)
  end
end
