class Document < ApplicationRecord
  belongs_to :user

  validates_presence_of :name, :file
end
