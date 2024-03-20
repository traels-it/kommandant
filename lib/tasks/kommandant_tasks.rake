namespace :kommandant do
  desc "Reindexes all commmands defined in the commands.json file (or whatever you called it)"
  task reindex_commands: :environment do
    puts "Reindexing all Kommandant commands"

    Kommandant::Command.reindex!
  end

  desc "Reindexes all models set up with Kommandant"
  task reindex_models: :environment do
    Rake::Task["meilisearch:reindex"].invoke
  end

  desc "Reindexes all commands and models. We recommend you run this task every time you deploy your application, to avoid any inconsistencies between what you expect to be indexed and what is actually indexed"
  task reindex: [:reindex_commands, :reindex_models]

  desc "Clears the Kommandant commands from the search engine"
  task clear_command_index: :environment do
    puts "Clearing the Kommandant commands"

    Kommandant::Command.remove_from_index!
  end

  desc "Clears the search engine of all models set up with Kommandant"
  task clear_model_index: :environment do
    Rake::Task["meilisearch:clear_indexes"].invoke
  end

  desc "Clears the search engine of all commands and models"
  task clear_indexes: [:clear_command_index, :clear_model_index]
end
