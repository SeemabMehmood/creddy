class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable, :lockable

  devise :two_factor_authenticatable, otp_secret_encryption_key: ENV["OTP_SECRET_KEY"]
end
