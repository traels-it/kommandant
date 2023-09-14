# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require_relative "../test/dummy/config/environment"
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../test/dummy/db/migrate", __dir__)]
ActiveRecord::Migrator.migrations_paths << File.expand_path("../db/migrate", __dir__)
require "rails/test_help"

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("fixtures", __dir__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + "/files"
  ActiveSupport::TestCase.fixtures :all
end

Kommandant.config.commands_path = "test/fixtures/files/commands.json"

MeiliSearch::Rails.configuration = {
  meilisearch_url: ENV.fetch("MEILI_HTTP_ADDR") { "http://localhost:7700" },
  meilisearch_api_key: ENV.fetch("MEILI_MASTER_KEY") { "MASTER_KEY" },
  per_environment: true
}

class ActiveSupport::TestCase
  setup do
    @@once ||= begin
      Kommandant::Command.reindex!
      MeiliSearch::Rails::Utilities.reindex_all_models
      true
    end
  end
end
