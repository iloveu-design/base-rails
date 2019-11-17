class Notification < ApplicationRecord
  belongs_to :user

  enum ntypes: [ :welcome ], _prefix: :ntypes

  default_scope { order("id desc") }
end
