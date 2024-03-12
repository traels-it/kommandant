require "test_helper"
require "generators/kommandant/install_generator"

module Kommandant
  class InstallGeneratorTest < Rails::Generators::TestCase
    tests Kommandant::InstallGenerator
    destination Rails.root.join("tmp/generators")
    setup :prepare_destination

    test "it copies the initializer file" do
      run_generator
      assert_file "config/initializers/kommandant.rb"
    end

    test "it copies a file with a sample command" do
      run_generator
      assert_file "config/kommandant/commands.json"
    end
  end
end
