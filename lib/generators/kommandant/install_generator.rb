require "rails/generators"

class Kommandant::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)

  def copy_templates
    template "initializer.rb", "config/initializers/kommandant.rb"
    template "commands.json", "config/kommandant/commands.json"
  end
end
