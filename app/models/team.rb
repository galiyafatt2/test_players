class Team < ApplicationRecord
  has_and_belongs_to_many :plays

  has_many :players
end