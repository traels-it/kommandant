Kommandant.configure do |config|
  config.pagination.enabled = false
  config.search_result_filter_lambda = ->(current_user, resource) { current_user.id == resource.id }
  config.admin_only_filter_lambda = nil
end
