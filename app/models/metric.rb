class Metric < ApplicationRecord
  has_and_belongs_to_many :players
  has_and_belongs_to_many :matches
end
