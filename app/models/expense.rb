class Expense < ApplicationRecord
  before_create :generate_random_id

  enum category: [:Utility, :Food, :Travel, :Shopping, :Vacation, :Airtime, :Data, :Rent, :Others]

  belongs_to :user

  validates_presence_of :category, :amount, :date

  scope :created_between, lambda { |start_date, end_date, user| where(user_id: user.id, date: start_date.beginning_of_day..end_date.end_of_day) }

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

  private
 
  def generate_random_id
    self.id = SecureRandom.random_number(100000000)
  end 
end
