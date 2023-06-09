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
      results = Kommandant::Command.search("Afslut")

      assert_equal "end_imitation", results.first.id
    end

    test ".find finds a command by its id" do
      result = Kommandant::Command.find("end_imitation")

      assert_equal "end_imitation", result.id
    end

    # describe "#name" do
    #   it "has a translated name" do
    #     command = find_command_for(id: "end_imitation")

    #     assert_equal "Afslut imitation", command.name
    #   end
    # end

    # describe "#placeholder" do
    #   it "has a translated placeholder" do
    #     command = find_command_for(id: "find_partner")

    #     assert_equal "Søg på partnernavn, -cvr eller id", command.placeholder
    #   end

    #   it "returns nil, when command requires no placeholder" do
    #     command = find_command_for(id: "end_imitation")

    #     assert_nil command.placeholder
    #   end
    # end

    def find_command_for(id:)
      data = @parsed_commands_file.find { |hash| hash["id"] == id }.symbolize_keys

      Kommandant::Command.new(**data)
    end
  end
end
