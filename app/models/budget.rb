class Budget < ApplicationRecord
  belongs_to :user

  validates_presence_of :start_date, :end_date
  validates :start_date, :end_date, overlap: { scope: 'user_id', message_content: 'and End date of this budget overlaps with another created budget.' }

  validate :date_config

  def date_deficit?
    end_date < start_date
  end

  def date_config
    errors.add(:start_date, 'must be lesser the End date') if date_deficit?
  end
end
