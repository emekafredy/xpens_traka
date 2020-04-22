class Budget < ApplicationRecord
  before_create :generate_random_id

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

  private
 
  def generate_random_id
    self.id = SecureRandom.random_number(100000000)
  end 
end
