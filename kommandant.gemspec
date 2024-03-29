require_relative "lib/kommandant/version"

Gem::Specification.new do |spec|
  spec.name = "kommandant"
  spec.version = Kommandant::VERSION
  spec.authors = ["Nicolai Bach Woller"]
  spec.email = ["woller@traels.it"]
  spec.homepage = "https://traels.it"
  spec.summary = "A command palette for Rails"
  spec.description = "A command palette built with Hotwire and Meilisearch"
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/traels-it/kommandant"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "dry-configurable", "~> 1.0", ">= 1.0.1"
  spec.add_dependency "meilisearch-rails", "~> 0.8.1"
  spec.add_dependency "rails", ">= 7.0.5"
  spec.add_dependency "turbo-rails", "~> 1.4"
  spec.add_development_dependency "tailwindcss-rails", "~> 2.0.30"
end
