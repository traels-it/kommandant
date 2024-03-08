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

  desc "Reindexes all commands and models. We recommend you run this task every time you deploy your application, to avoid any inconsistencies between what you expect to be indexed and what is actually indexed."
  task reindex: [:reindex_commands, :reindex_models]
end
