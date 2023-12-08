require "test_helper"

module Kommandant
  class Commands::SearchResultTest < ActiveSupport::TestCase
    setup do
      @parsed_commands_file = JSON.parse(File.read("test/fixtures/files/commands.json"))
      @user = User.new(id: 1, name: "Isaiah Wiegand")
    end

    test "path is inferable from the resource class to be used for further redirecting" do
      command = find_command_for(id: "find_user")
      search_result = Kommandant::Commands::SearchResult.new(command: command, resource: @user)

      assert_equal "/users/#{@user.id}", search_result.path
    end

    test "path returns an explicitly defined redirect_path" do
      command = find_command_for(id: "imitate_user")

      search_result = Kommandant::Commands::SearchResult.new(command: command, resource: @user)

      assert_equal "/become/#{@user.id}", search_result.path
    end

    test "name translates the text to use for a search result" do
      command = find_command_for(id: "imitate_user")
      search_result = Kommandant::Commands::SearchResult.new(command: command, resource: @user)

      assert_equal @user.name, search_result.name
    end

    test "name interpolates with defined text keys for translation" do
      command = find_command_for(id: "find_user")

      search_result = Kommandant::Commands::SearchResult.new(command: command, resource: @user)

      assert_equal "Show #{@user.name}", search_result.name
    end

    def find_command_for(id:)
      data = @parsed_commands_file.find { |hash| hash["id"] == id }.symbolize_keys

      Kommandant::Command.new(**data)
    end
  end
end
