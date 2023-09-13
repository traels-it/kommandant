class Kommandant::Commands::SearchesController < ApplicationController
  ITEMS_PER_PAGE = 10

  before_action :set_command

  def show
    # Pagy would be most efficiently used on the output of the search method - but we need to check, that the user is
    # actually allowed to view the resource
    @resources = @command.resource_class.constantize.search(params[:query])
      .select { |resource| can? :show, resource }

    @results = @resources.map do |resource|
      Kommandant::Commands::SearchResult.new(command: @command, resource: resource)
    end

    @pagy, @results = pagy_array(@results, items: ITEMS_PER_PAGE)
  end

  private

  def set_command
    @command = Kommandant::Command.find(params[:command_id])
  end
end
