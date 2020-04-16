class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :incomes
  has_many :expenses

  def self.create_from_provider_data(provider_data)
    where(email: provider_data.info.email).first_or_create do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = provider_data.info.first_name || provider_data.info.name.split[0]
      user.last_name = provider_data.info.last_name || provider_data.info.name.split[1]
      user.save
    end
  end
end
