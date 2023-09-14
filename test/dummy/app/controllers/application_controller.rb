class ApplicationController < ActionController::Base
  include Pagy::Backend

  def current_user
    User.first
  end

  def current_ability
    current_user
  end
end
