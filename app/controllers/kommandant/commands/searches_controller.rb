class Kommandant::Commands::SearchesController < ApplicationController
  ITEMS_PER_PAGE = 10

  before_action :set_command

  def show
    @results = filtered_resources.map do |resource|
      Kommandant::Commands::SearchResult.new(command: @command, resource: resource)
    end

    @pagy, @results = pagy_array(@results, items: ITEMS_PER_PAGE)
  end

  private

  def set_command
    @command = Kommandant::Command.find(params[:command_id])
  end

  def filtered_resources
    # Pagy would be most efficiently used on the output of the search method - but we need to check, that the user is
    # actually allowed to view the resource
    @resources ||= @command.resource_class.constantize.search(params[:query]).filter do |resource|
      Kommandant.config.search_result_filter_lambda.call(current_ability, resource)
    end
  end
end
