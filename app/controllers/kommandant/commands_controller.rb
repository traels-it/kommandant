module Kommandant
  class CommandsController < ApplicationController
    before_action :set_command

    def show
      if Kommandant.config.recent_commands.enabled
        current_user.recent_commands.prepend(@command.id)
      end
    end

    private

    def set_command
      @command = Kommandant::Command.find(params[:id])
    end
  end
end
