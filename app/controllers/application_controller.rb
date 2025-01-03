# frozen_string_literal: true
class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :ensure_mfa_verified

  private

  def ensure_mfa_verified
    return unless current_user&.otp_required_for_login? && !session[:mfa_verified]

    redirect_to verify_mfa_path, alert: 'You need to verify your MFA code to continue.'
  end
end
