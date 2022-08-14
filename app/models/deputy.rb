class Deputy < ApplicationRecord
  belongs_to :ceap
  has_many :expenses
end
