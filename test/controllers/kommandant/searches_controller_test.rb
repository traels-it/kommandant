require "test_helper"

class SearchesControllerTest < ActionDispatch::IntegrationTest
  describe "#search" do
    before do
      sign_in users(:not_admin)
    end

    it "renders search results, when there are any" do
      get kommandant.searches_path, params: {query: "find"}

      assert_select "ul li", count: 2 do
        assert_select "a[href='#{kommandant.command_path(:find_user)}']"
        assert_select "a[href='#{kommandant.command_path(:find_post)}']"
      end
    end

    it "renders an empty state, when there are no results" do
      get kommandant.searches_path, params: {query: "missing"}

      assert_select "div.py-14", text: "#{I18n.t("kommandant.shared.command_palette.empty_state.text")} missing"
    end

    describe "admin only filter" do
      it "filters admin_only results" do
        get kommandant.searches_path, params: {query: "end"}

        assert_select "a span", text: "End imitation", count: 0
        assert_select "a[href='/logout']", count: 0
      end

      it "shows admin only results, when the user is an admin" do
        sign_in users(:admin)

        get kommandant.searches_path, params: {query: "end"}

        assert_select "a span", text: "End imitation", count: 1
        assert_select "
        a[href='/logout']", count: 1
      end

      it "handles a nil admin_only_filter_lambda" do
        old_lamba = Kommandant.config.admin_only_filter_lambda
        Kommandant.config.admin_only_filter_lambda = nil

        get kommandant.searches_path, params: {query: "end"}

        assert_response :success

        Kommandant.config.admin_only_filter_lambda = old_lamba
      end
    end
  end
end
