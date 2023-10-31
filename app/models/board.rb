class Board < ApplicationRecord
  has_many :categories
  has_many :posts

  accepts_nested_attributes_for :categories, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9_]+\Z/, message: I18n.t('msgs.error.allowed_only_lower_case') }

  default_scope { order("id desc") }
end
