class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :set_current

  def current_user
    @current_user ||= Current.user
  end

  def set_current
    Current.user ||= User.find(session[:user_id])
  end

  def current_ability
    current_user
  end

  def current_admin
    return current_user if current_user.admin?

    nil
  end
end
