require "kommandant/version"
require "kommandant/engine"
require "meilisearch-rails"
require "dry-configurable"

module Kommandant
  extend Dry::Configurable

  setting :commands_path, default: "config/kommandant/commands.json"
  setting :search_result_filter_lambda
  setting :admin_only_filter_lambda
  setting :parent_controller, default: "::ApplicationController"
  setting :current_user_method, default: "current_user"

  autoload :Command, "kommandant/command"
end
