# frozen_string_literal: true
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable, :lockable,
         :two_factor_authenticatable, otp_secret_encryption_key: ENV['OTP_SECRET_KEY']
  enum role: { admin: 0, user: 1 }

  def admin?
    role == 'admin'
  end

  def generate_otp_secret
    self.otp_secret ||= ROTP::Base32.random_base32
  end

  def validate_otp(code)
    totp = ROTP::TOTP.new(otp_secret)
    totp.verify(code, drift_behind: 30)
  end
end
