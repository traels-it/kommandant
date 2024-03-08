require "test_helper"

module Kommandant
  class CommandTest < ActiveSupport::TestCase
    setup do
      @parsed_commands_file = JSON.parse(File.read("test/fixtures/files/commands.json"))
    end

    test ".reindex loads all commands from a JSON config file and creates or updates them in the search engine" do
      expected_result = @parsed_commands_file

      Kommandant::Command.reindex!

      assert_equal expected_result, MeiliSearch::Rails.client.index("commands").documents["results"]
    end

    test ".search searches the commands in meilisearch by their translated name" do
      results = Kommandant::Command.search("End")

      assert_equal "end_imitation", results.first.id
    end

    test ".find finds a command by its id" do
      result = Kommandant::Command.find("end_imitation")

      assert_equal "end_imitation", result.id
    end

    test ".all returns all commands" do
      expected_result = @parsed_commands_file.map { |hash| Kommandant::Command.new(**hash.symbolize_keys) }

      result = Kommandant::Command.all

      assert_equal 4, result.size
      result.each_with_index do |command, index|
        assert_equal expected_result[index].id, command.id
      end
    end

    test "it has a translatable name" do
      command = find_command_for(id: "end_imitation")

      assert_equal "End imitation", command.name
    end

    test "it shows an error message when the name is not translated" do
      I18n.with_locale(:da) do
        command = find_command_for(id: "end_imitation")

        assert_equal "no translation for da.name in Meilisearch", command.name
      end
    end

    test "it has a translated placeholder" do
      command = find_command_for(id: "find_user")

      assert_equal "Search for user name", command.placeholder
    end

    test "placeholder is nil, when command has none" do
      command = find_command_for(id: "end_imitation")

      assert_nil command.placeholder
    end

    def find_command_for(id:)
      data = @parsed_commands_file.find { |hash| hash["id"] == id }.symbolize_keys

      Kommandant::Command.new(**data)
    end
  end
end
