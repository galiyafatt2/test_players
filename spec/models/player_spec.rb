require 'rails_helper'

RSpec.describe Player, type: :model do
  let(:team) { create(:team) }
  let(:metric) { create(:metric) }

  describe "#mark_metric_in_match" do
    let(:player) { create(:player, team: team) }
    let(:match) { create(:match, teams: [team]) }

    it "adds the metric to the player's metrics list if player's team participates in the match" do
      player.mark_metric_in_match(metric.id, match.id)
      expect(player.metrics).to include(metric)
    end

    it "raises an error if player's team doesn't participate in the match" do
      another_match = create(:match) # Create a match without player's team
      expect { player.mark_metric_in_match(metric.id, another_match.id) }.to raise_error("Player's team doesn't participate in the match")
    end
  end

  describe "#executed_metric_in_last_five_matches?" do
    let(:player) { create(:player, team: team) }
    let(:matches) { create_list(:match, 5, teams: [team], metrics: [metric]) }

    it "returns true if player has executed the metric in one of the last 5 matches" do
      player.mark_metric_in_match(metric.id, matches[1].id) # Mark metric in the last 4 matches
      expect(player.executed_metric_in_last_five_matches?(metric.id)).to be_truthy
    end

    it "returns false if player hasn't executed the metric in any of the last 5 matches" do
      expect(player.executed_metric_in_last_five_matches?(metric.id)).to be_falsey
    end
  end


  describe "#top_players_by_metric" do
    let(:team) { create(:team) }
    let(:metric) { create(:metric) }
    let!(:matches) { create_list(:match, 5, teams: [team]) }

    it "returns top players by metric within a specific team" do
      player1, player2, player3 = create_list(:player, 3, team: team)

      player1.mark_metric_in_match(metric.id, matches.first.id)
      player1.mark_metric_in_match(metric.id, matches.second.id)
      player1.mark_metric_in_match(metric.id, matches.third.id)
      player2.mark_metric_in_match(metric.id, matches.second.id)
      player2.mark_metric_in_match(metric.id, matches.first.id)
      player3.mark_metric_in_match(metric.id, matches.first.id)

      expect(Player.top_players_by_metric(metric.id, team.id)).to eq([player1, player2, player3])
    end

    it "returns top players by metric across all teams if no team is specified" do
      player1, player2, player3 = create_list(:player, 3, team: team)
      another_player = create(:player, team: create(:team)) # Create first player for another team

      matches.first.teams << another_player.team

      player1.mark_metric_in_match(metric.id, matches.first.id)
      player1.mark_metric_in_match(metric.id, matches.second.id)
      player1.mark_metric_in_match(metric.id, matches.third.id)
      player1.mark_metric_in_match(metric.id, matches[-1].id)
      player2.mark_metric_in_match(metric.id, matches.second.id)
      player2.mark_metric_in_match(metric.id, matches.first.id)
      player2.mark_metric_in_match(metric.id, matches.third.id)
      player3.mark_metric_in_match(metric.id, matches.first.id)
      player3.mark_metric_in_match(metric.id, matches.second.id)
      another_player.mark_metric_in_match(metric.id, matches.first.id)

      expected_players = [player1, player2, player3, another_player]
      expect(Player.top_players_by_metric(metric.id)).to eq(expected_players)
    end
  end
end
