class Board::Post < ApplicationRecord
  include Commentable

  belongs_to :board

  acts_as_taggable_on :tags

  validates :board, presence: true
  validates :title, presence: true
  validates :body, presence: true
end
