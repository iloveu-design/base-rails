class Follow < ApplicationRecord
  belongs_to :followed_user, foreign_key: 'followed_id', class_name: 'User'
  belongs_to :follower_user, foreign_key: 'follower_id', class_name: 'User'
end
