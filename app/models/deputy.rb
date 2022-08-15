class Deputy < ApplicationRecord
  belongs_to :ceap
  has_many :expenses

  def higher_expense
    expenses.sort_by(&:value).reverse.first
  end
end
