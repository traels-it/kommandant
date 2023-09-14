require "test_helper"

# Needs a more generic name, maybe? Default? Navigation? Kommmandant::CommandPaletteController? Is this premature?
# Should I built a more thorough dummy app, when I extract this? Right now meilisearch is running in a docker container for the main app
# Should ViewComponent be a requirement? Or should I try to reimplement the views with partials?
# Also I should probably redesign the palette or ask for permission to use the design from TailwindUI...
class SearchesControllerTest < ActionDispatch::IntegrationTest
  describe "#search" do
    it "renders search results, when there are any" do
      get kommandant.searches_path, params: {query: "find"}

      assert_select "ul li", count: 1 do
        assert_select "a[href='#{kommandant.command_path(:find_user)}']"
      end
    end

    it "renders an empty state, when there are no results" do
      get kommandant.searches_path, params: {query: "missing"}

      assert_select "div.py-14", text: "#{I18n.t("kommandant.shared.command_palette.empty_state.text")} missing"
    end

    it "filters admin_only results" do
      skip
      log_in(partners_employees(:partner_employee))

      get kommandant.searches_path, params: {query: "end"}

      assert_select "a span", text: "Afslut imitation", count: 0
      assert_select "a[href='/logout']", count: 0
    end
  end
end
