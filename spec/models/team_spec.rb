require 'rails_helper'

RSpec.describe Team, type: :model do
  subject(:team) { build(:team) }

  it { is_expected.to have_and_belong_to_many(:plays) }
  it { is_expected.to have_many(:players) }
end
