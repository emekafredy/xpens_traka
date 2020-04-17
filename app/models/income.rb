class Income < ApplicationRecord
  enum category: [:salary, :others]

  belongs_to :user

  validates :category, presence: true
  validates :amount, presence: true
  validates :date, presence: true

  INCOME_CATEGORIES = ['salary', 'other'].freeze

  def self.income_categories
    INCOME_CATEGORIES
  end
end
