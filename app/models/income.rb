class Income < ApplicationRecord
  before_create :generate_random_id

  enum category: [:Salary, :Others]

  belongs_to :user

  validates_presence_of :category, :amount, :date

  scope :created_between, ->(start_date, end_date, user) { where(user_id: user.id, date: start_date.beginning_of_day..end_date.end_of_day) }

  INCOME_CATEGORIES = %w[Salary Others].freeze

  def self.income_categories
    INCOME_CATEGORIES
  end

  private

  def generate_random_id
    self.id = SecureRandom.random_number(100_000_000)
  end
end
