class Income < ApplicationRecord
  enum category: [:Salary, :Others]

  belongs_to :user

  validates :category, presence: true
  validates :amount, presence: true
  validates :date, presence: true

  INCOME_CATEGORIES = %w[Salary Others].freeze

  def self.income_categories
    INCOME_CATEGORIES
  end
end
