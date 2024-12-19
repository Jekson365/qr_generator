class User < ApplicationRecord
  validates :user,uniqueness: true

  has_many :user_finals
  has_many :qr_codes, :class_name => 'Qrs::Qrcode'
  has_many :user_images, :class_name => 'UserImages::UserImage'
end