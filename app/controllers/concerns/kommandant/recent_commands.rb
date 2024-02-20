module Kommandant::RecentCommands
  extend ActiveSupport::Concern

  included do
    before_action :set_recent_commands
  end

  def set_recent_commands
    return unless current_user.present?

    if current_user.recent_commands.elements.any?
      @recent_commands ||= current_user.recent_commands.elements.map do |command_id|
        Kommandant::Command.find(command_id)
      end
    else
      Kommandant::Command.all.each do |command|
        current_user.recent_commands << command.id
      end
    end
  end
end
