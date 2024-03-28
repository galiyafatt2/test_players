class Play < ApplicationRecord
  has_and_belongs_to_many :teams
  has_and_belongs_to_many :metrics
end