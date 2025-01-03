# frozen_string_literal: true

class MfaController < ApplicationController
  before_action :authenticate_user!

  def enable
    @otp_secret = current_user.generate_otp_secret
    current_user.update(otp_secret: @otp_secret)
  end

  def enable_mfa
    if current_user.validate_otp(params[:otp_code])
      current_user.update(otp_required_for_login: true)
      redirect_to root_path, notice: 'MFA enabled successfully!'
    else
      flash.now[:alert] = 'Invalid OTP code. Please try again.'
      render :enable
    end
  end

  def disable
    current_user.update(otp_required_for_login: false, otp_secret: nil)
    redirect_to root_path, notice: 'MFA disabled successfully!'
  end

  def verify
    if current_user.validate_otp(params[:otp_code])
      session[:mfa_verified] = true
      redirect_to root_path, notice: 'MFA verification successful!'
    else
      flash.now[:alert] = 'Invalid OTP code. Please try again.'
      render :verify
    end
  end
end
