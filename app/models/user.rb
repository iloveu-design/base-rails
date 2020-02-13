class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :naver, :kakao]

  has_many :notifications
  has_many :follows
  has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Follow', dependent: :destroy
  has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Follow', dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed_user
  has_many :followers, through: :passive_relationships, source: :follower_user

  enum role: { admin: "admin", general: "general" }

  scoped_search on: [:name, :uid, :email]
  scope :recent, -> { order("created_at DESC") }
  scope :hibernated, -> { where(hibernated: true) }

  #validates :name, presence: :true

  after_create do |obj|
    if obj.role.nil?
      obj.role = :general
      obj.save
    end
  end

  def admin?
    role == 'admin'
  end

  def self.set_oauth(auth)
    user = User.new do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.email =  auth['email']
      user.password = Devise.friendly_token[0,20]
      user.name = auth["name"]
      user.role = :general
    end
    user.save
    user
  end

  def self.find_sns_oauth(uid, provider)
    where(uid: uid, provider: provider).first
  end

  def follow!(other)
    other.followers << self
  end

  def following?(other)
    Follow.where(followed_id: other.id, follower_id: self.id).any?
  end

  def unfollow!(other)
    Follow.where(followed_id: other.id, follower_id: self.id).delete_all
  end
end