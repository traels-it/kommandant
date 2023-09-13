module Kommandant
  class SearchesController < ApplicationController
    def index
      @results = Kommandant::Command.search(params[:query])

      unless Kommandant.config.admin_only_filter_lambda.call(current_user, current_admin)
        @results.reject!(&:admin_only?)
      end
    end

    def new
    end
  end
end
