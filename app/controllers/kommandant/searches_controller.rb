module Kommandant
  class SearchesController < ApplicationController
    def index
      @results = Kommandant::Command.search(params[:query])

      # unless current_user.admin? || current_admin
      #   @results.reject!(&:admin_only?)
      # end
    end

    def new
    end
  end
end
