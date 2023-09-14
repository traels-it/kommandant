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

      assert_select "ul li a[href='#{expected_path}']", text: resource.name
    end

    it "renders a default partial, if no partial is found" do
      skip
    end

    describe "filtering results" do
      it "finds results, user is allowed to see" do
        resource = users(:not_admin)
        expected_path = user_path(resource)

        get kommandant.command_searches_path(:find_user), params: {query: resource.id}

        assert_select "ul li a[href='#{expected_path}']", resource.name
      end

      it "does not find results, user is not allowed to see" do
        filtered_resource = users(:admin)

        get kommandant.command_searches_path(:find_user), params: {query: filtered_resource.id}

        assert_select "ul li", count: 0
      end
    end
  end
end
