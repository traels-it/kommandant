module Kommandant
  class ApplicationController < Kommandant.config.parent_controller.constantize
    layout false

    private

    alias_method :current_user, Kommandant.config.current_user_method
  end
end
