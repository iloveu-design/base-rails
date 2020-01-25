class Reservation < ApplicationRecord
  belongs_to :space

  default_scope { order("id desc") }
end
