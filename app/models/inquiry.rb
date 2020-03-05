class Inquiry < ApplicationRecord
  belongs_to :user

  scope :recent, -> { order("created_at DESC") }
end
