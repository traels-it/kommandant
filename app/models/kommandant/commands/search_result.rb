module Kommandant
  class Commands::SearchResult
    def initialize(command:, resource:)
      @command = command
      @resource = resource
      @translator = command.translator
    end

    attr_reader :resource
    delegate :icon, to: :command

    def name
      if translator.exists?(I18n.locale, "result_text")
        translation_attributes = {}
        command.text_keys.each do |key|
          translation_attributes[key.to_sym] = indexed_attribute_for(resource, key)
        end
        translator.translate(I18n.locale, "result_text", **translation_attributes)
      else
        command.text_keys.map do |text_key|
          indexed_attribute_for(resource, text_key)
        end.join(", ")
      end
    end

    def path
      return command.redirect_path.gsub(":id", resource.id.to_s) if command.redirect_path

      "/#{command.resource_class.downcase.pluralize}/#{resource.id}"
    end

    def http_method
      :get
    end

    private

    attr_reader :command, :translator

    def indexed_attribute_for(resource, text_key)
      resource.meilisearch_settings.get_attributes(resource)[text_key]
    end
  end
end
