require "test_helper"

class Kommandant::Commands::SearchesControllerTest < ActionDispatch::IntegrationTest
  before do
    sign_in(users(:not_admin))
  end

  describe "#show" do
    it "finds resources" do
      resource = users(:not_admin)
      expected_path = user_path(resource)

      get kommandant.command_searches_path(:find_user), params: {query: resource.id}

      assert_select "ul li a[href='#{expected_path}'] span", text: "Show #{resource.name}"
    end

    it "highlights the search term in the results" do
      resource = users(:not_admin)

      get kommandant.command_searches_path(:find_user), params: {query: resource.name[0..-4]}

      assert_select "ul li a" do |result|
        assert_select result, "b.kommandant-bg-amber-200", text: resource.name[0..-4]
      end
    end

    it "renders a default partial, if no partial is found" do
      old_filter = Kommandant.config.search_result_filter_lambda
      Kommandant.config.search_result_filter_lambda = nil

      resource = posts(:published)
      expected_path = post_path(resource)

      get kommandant.command_searches_path(:find_post), params: {query: resource.id}

      assert_select "ul li a[href='#{expected_path}']" do
        assert_select "span", text: "Show #{resource.name}"
      end

      Kommandant.config.search_result_filter_lambda = old_filter
    end

    describe "filtering results" do
      it "finds results, user is allowed to see" do
        resource = users(:not_admin)
        expected_path = user_path(resource)

        get kommandant.command_searches_path(:find_user), params: {query: resource.id}

        assert_select "ul li a[href='#{expected_path}'] span", "Show #{resource.name}"
      end

      it "does not find results, user is not allowed to see" do
        filtered_resource = users(:admin)

        get kommandant.command_searches_path(:find_user), params: {query: filtered_resource.id}

        assert_select "ul li", count: 0
      end
    end
  end
end
