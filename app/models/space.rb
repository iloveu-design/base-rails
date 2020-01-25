class Space < ApplicationRecord
  has_many :reservations

  has_one_attached :image
  has_many_attached :event_photos
  has_many_attached :cafe_photos
  has_many_attached :usage_photos
end
