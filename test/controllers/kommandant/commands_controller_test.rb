require "test_helper"

class CommandsControllerTest < ActionDispatch::IntegrationTest
  before do
    sign_in(users(:not_admin))
  end

  describe "#show" do
    it "shows a back button" do
      # should the link back actually be to a command_palettes#new or command_palettes#show?
      # that might make state handling simpler
      get kommandant.command_path(:find_user)

      assert_select "a.kommandant-inline-flex", text: "Find user", href: kommandant.searches_path
    end

    it "shows a new search form" do
      get kommandant.command_path(:find_user)

      assert_select "form[action='#{kommandant.command_searches_path(:find_user)}']" do
        assert_select "input", name: "query", placeholder: "Søg på kundenavn, nummerplade eller id"
      end
    end

    it "adds the command to the current user's recent searches (requires kredis)" do
      user = users(:not_admin)
      assert_difference -> { user.recent_commands.elements.count }, 1 do
        get kommandant.command_path(:find_user)

        assert_equal "find_user", user.recent_commands.elements.first
      end
    end

    it "works even when the application is not setup with recent commands" do
      Kommandant.config.recent_commands.enabled = false

      get kommandant.command_path(:find_user)

      assert_response :success

      Kommandant.config.recent_commands.enabled = true
    end
  end
end
