require_relative "lib/kommandant/version"

Gem::Specification.new do |spec|
  spec.name        = "kommandant"
  spec.version     = Kommandant::VERSION
  spec.authors     = ["Nicolai Bach Woller"]
  spec.email       = ["woller@traels.it"]
  spec.homepage    = "https://traels.it"
  spec.summary     = "A command palette for Rails"
  spec.description = "A command palette built with Hotwire and Meilisearch"
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/traels-it/kommandant"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.5"
end
