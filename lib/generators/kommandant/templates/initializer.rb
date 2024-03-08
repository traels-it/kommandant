Kommandant.configure do |config|
  # Commands are a central part of Kommandant. They are loaded from a json file at "config/kommandant/commands.json" by default. We will go into more detail about commands further down the page.
  # config.commands_path = "your/custom/path"

  # When meilisearch returns a result, it might include items, that the current user is not allowed to see. You can filter these results with a lamda. This setting has no default, but below is an example that works with cancancan.
  # config.search_result_filter_lambda = ->(current_ability, resource) { current_ability.can?(:show, resource) }

  # Another search result filter. We use this to allow admins, who are impersonating users, access to all their commands. This setting has no default.
  # config.admin_only_filter_lambda = ->(current_user, current_admin) { current_user.admin? || current_admin }

  # If you want Kommandant to use a different parent controller, this is the setting for you. Defaults to ApplicationController
  # config :parent_controller = "YourVerySpecialController"

  # We assume there is a logged in user and therefore a current_user method. The name of this method can be set here. It defaults to current_user.
  # config.current_user_method = current_account

  # If you use Kredis, Kommandant can display the current user's most recently used commands. It requires your user model to have kredis_unique_list called recent_commands. If you don't use Kredis or do not want this behavior, it can be disabled. It defaults to being enabled.
  # class User < ApplicationRecord
  # kredis_unique_list :recent_commands, limit: 5
  # config.recent_commands.enabled = false

  # When a search returns a lot of results, it can be useful to paginate them. We use Pagy by default to handle this. If you do not use Pagy, this functinality can be turned off or configured to suit your needs. It defaults to being enabled.
  # config.pagination.enabled = false
  # config.pagination.items_per_page = 10 # defaults to 10
  # config.pagination.pagination_lambda = ->(results, items, controller) { controller.send(:pagy_array, results, items: items) }
  # config.pagination.info_label_lambda = ->(pagination, controller) { controller.send(:pagy_info, pagination).html_safe }
  # config.pagination.module = "Pagy::Frontend"
end
