class Expense < ApplicationRecord
  enum category: [:Utility, :Food, :Travel, :Shopping, :Vacation, :Airtime, :Data, :Rent, :Others]

  belongs_to :user

  validates :category, presence: true
  validates :amount, presence: true
  validates :date, presence: true

  EXPENSE_CATEGORIES = %w[
    Utility
    Food
    Travel
    Shopping
    Vacation
    Airtime
    Data
    Rent
    Others
  ].freeze

  def self.expense_categories
    EXPENSE_CATEGORIES
  end
end
