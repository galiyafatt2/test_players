require 'rails_helper'

RSpec.describe Player, type: :model do
  subject(:player) { build(:player) }

  it { is_expected.to belong_to(:team) }
  it { is_expected.to have_and_belong_to_many(:metrics) }

  let(:team) { create(:team) }
  let(:metric) { create(:metric) }

  describe "#mark_metric_in_match" do
    let(:player) { create(:player, team: team) }
    let(:play) { create(:play, teams: [team]) }

    it "adds the metric to the player's metrics list if player's team participates in the match" do
      player.mark_metric_in_play(metric.id, play.id)
      expect(player.metrics).to include(metric)
    end
  end

  describe "#executed_metric_in_last_five_matches?" do
    let(:player) { create(:player, team: team) }
    let(:plays) { create_list(:play, 5, teams: [team], metrics: [metric]) }

    it "returns true if player has executed the metric in one of the last 5 matches" do
      player.mark_metric_in_play(metric.id, plays[1].id) # Mark metric in the last 4 matches
      expect(player.executed_metric_in_last_five_plays?(metric.id)).to be_truthy
    end

    it "returns false if player hasn't executed the metric in any of the last 5 matches" do
      expect(player.executed_metric_in_last_five_plays?(metric.id)).to be_falsey
    end
  end
end
