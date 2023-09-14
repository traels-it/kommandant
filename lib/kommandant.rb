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
  setting :pagination do
    setting :enabled, default: true
    setting :items_per_page, default: 10
    setting :pagination_lambda, default: ->(results, items, controller) { controller.send(:pagy_array, results, items: items) }
    setting :info_label_lambda, default: ->(pagination, controller) { controller.send(:pagy_info, pagination).html_safe }
    setting :module, default: "Pagy::Frontend"
  end

  autoload :Command, "kommandant/command"
end
