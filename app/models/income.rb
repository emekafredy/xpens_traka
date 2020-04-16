class Income < ApplicationRecord
  enum category: [:salary, :others]

  belongs_to :user
end
