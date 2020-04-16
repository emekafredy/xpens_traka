class Expense < ApplicationRecord
  enum category: [:utility_bills, :food, :travel, :shopping, :vacation, :airtime, :data_subscription, :rent, :others]

  belongs_to :user
end
