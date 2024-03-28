require 'rails_helper'

RSpec.describe Play, type: :model do
  subject(:play) { build(:play) }

  it { is_expected.to have_and_belong_to_many(:teams) }
  it { is_expected.to have_and_belong_to_many(:metrics) }
end
