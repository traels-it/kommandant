class SessionsController < ApplicationController
  skip_before_action :set_current

  def create
    session[:user_id] = params[:user_id]
  end
end
