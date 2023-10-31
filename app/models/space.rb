class Space < ApplicationRecord
  has_many :reservations

  has_one_attached :image
  has_many_attached :event_photos
  has_many_attached :cafe_photos
  has_many_attached :usage_photos

  scoped_search on: [:name]

  validates :name, presence: true

  def cover_image_path(size)
    if self.image.attached? 
      image_key = self.image.key
      image_location_on_disk = ActiveStorage::Blob.service.path_for(image_key)
      if File.exist?(image_location_on_disk)
        Rails.application.routes.url_helpers.rails_representation_url(self.image.variant(resize: size).processed, only_path: true)
      else  
        ActionController::Base.helpers.image_url('og.png')
      end
    else  
      ActionController::Base.helpers.image_url('og.png')
    end
  end
end
