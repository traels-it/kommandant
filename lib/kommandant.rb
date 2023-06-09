require "kommandant/version"
require "kommandant/engine"
require "meilisearch-rails"
require "dry-configurable"

module Kommandant
  extend Dry::Configurable

  setting :commands_path, default: "config/kommandant/commands.json"

  autoload :Command, "kommandant/command"
end
