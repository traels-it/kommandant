require "test_helper"

class CommandsControllerTest < ActionDispatch::IntegrationTest
  describe "#show" do
    it "shows a back button" do
      # should the link back actually be to a command_palettes#new or command_palettes#show?
      # that might make state handling simpler
      get kommandant.command_path(:find_user)

      assert_select "a.inline-flex", text: "Find user", href: kommandant.searches_path
    end

    it "shows a new search form" do
      get kommandant.command_path(:find_user)

      assert_select "form[action='#{kommandant.command_searches_path(:find_user)}']" do
        assert_select "input", name: "query", placeholder: "Søg på kundenavn, nummerplade eller id"
      end
    end

    it "adds the command to the current user's recent searches" do
      skip
      assert_difference -> { admin.recent_commands.elements.count }, 1 do
        get kommandant.command_path(:find_user)

        assert_equal "find_user", admin.recent_commands.elements.first
      end
    end
  end
end
