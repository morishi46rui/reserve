class User < ApplicationRecord
  
  has_many :rooms
  has_many :reservations

  has_one_attached :avatar
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, presence: true, length: {maximum: 50}

  def is_active_host
    !self.merchant_id.blank?
  end

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    if user
      if !user.provider
        user.update(uid: auth.uid, provider: auth.provider, image: auth.info.image)
      end      
      return user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.full_name = auth.info.name   # ユーザーモデルに名前があると仮定
        user.image = auth.info.image # ユーザーモデルに画像があると仮定
        user.uid = auth.uid
        user.provider = auth.provider
      end
    end
  end

end
