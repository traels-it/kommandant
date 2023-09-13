module Kommandant
  class CommandsController < ApplicationController
    before_action :set_command

    def show
      current_user.recent_commands.prepend(@command.id)
    end

    private

    def set_command
      @command = Kommandant::Command.find(params[:id])
    end
  end
end
