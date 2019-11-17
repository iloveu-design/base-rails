class Board::Post < ApplicationRecord
  include Commentable

  belongs_to :board

  validates :board, presence: true
  validates :title, presence: true
  validates :body, presence: true
end
