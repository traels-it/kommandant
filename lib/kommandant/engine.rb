module Kommandant
  class Engine < ::Rails::Engine
    isolate_namespace Kommandant
  
    PRECOMPILE_ASSETS = %w( kommandant.js )
    initializer "kommandant.assets" do |app|
      if Rails.application.config.respond_to?(:assets)
        Rails.application.config.assets.precompile += PRECOMPILE_ASSETS
      end
    end
  end
end
