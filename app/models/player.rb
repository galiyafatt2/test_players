class Player < ApplicationRecord
  belongs_to :team

  has_and_belongs_to_many :metrics

  def mark_metric_in_play(metric_id, play_id)
    metric = Metric.find(metric_id)
    match = Play.find(play_id)
    metrics << metric if match.teams.include?(team)
  end

  def executed_metric_in_last_five_plays?(metric_id)
    team_matches = team.plays.order(date: :desc).limit(5)
    team_matches.each do |play|
      return true if play.teams.include?(team) && metrics.exists?(id: metric_id)
    end
    false
  end
end
