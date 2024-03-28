require 'rails_helper'

RSpec.describe Metric, type: :model do
  subject(:metric) { build(:metric) }

  it { is_expected.to have_and_belong_to_many(:players) }
  it { is_expected.to have_and_belong_to_many(:plays) }

  describe "#top_players_by_metric" do
    let(:team) { create(:team) }
    let(:metric) { create(:metric) }
    let(:plays) { create_list(:play, 5, teams: [team]) }

    it "returns top players by metric within a specific team" do
      player1, player2, player3 = create_list(:player, 3, team: team)
      player1.mark_metric_in_play(metric.id, plays.first.id)
      player1.mark_metric_in_play(metric.id, plays.second.id)
      player1.mark_metric_in_play(metric.id, plays.third.id)
      player2.mark_metric_in_play(metric.id, plays.second.id)
      player2.mark_metric_in_play(metric.id, plays.first.id)
      player3.mark_metric_in_play(metric.id, plays.first.id)

      result = metric.top_players_by_metric(team.id)
      expected_players = [player1, player2, player3]

      expect(result).to eq(expected_players)
    end

    it "returns top players by metric across all teams if no team is specified" do
      player1, player2, player3 = create_list(:player, 3, team: team)
      another_player = create(:player, team: create(:team)) # Create first player for another team
      plays.first.teams << another_player.team
      player1.mark_metric_in_play(metric.id, plays.first.id)
      player1.mark_metric_in_play(metric.id, plays.second.id)
      player1.mark_metric_in_play(metric.id, plays.third.id)
      player1.mark_metric_in_play(metric.id, plays[-1].id)
      player2.mark_metric_in_play(metric.id, plays.second.id)
      player2.mark_metric_in_play(metric.id, plays.first.id)
      player2.mark_metric_in_play(metric.id, plays.third.id)
      player3.mark_metric_in_play(metric.id, plays.first.id)
      player3.mark_metric_in_play(metric.id, plays.second.id)
      another_player.mark_metric_in_play(metric.id, plays.first.id)

      result = metric.top_players_by_metric
      expected_players = [player1, player2, player3, another_player]

      expect(result).to eq(expected_players)
    end
  end
end
