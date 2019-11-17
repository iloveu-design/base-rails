class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :naver, :kakao]

  #validates :name, presence: :true

  scope :recent, -> { order("created_at DESC") }
  scope :hibernated, -> { where(hibernated: true) }

  after_create do |obj|
    if obj.role.nil?
      obj.role = 'general'
      obj.save
    end
  end

  ROLE = {
    'admin' => '관리자',
    'general' => '일반회원'
  }

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
      user.role = 'general'
    end
    user.save
    user
  end

  def self.find_sns_oauth(uid, provider)
    where(uid: uid, provider: provider).first
  end
end