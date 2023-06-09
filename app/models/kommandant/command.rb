module Kommandant
  class Command
    class << self
      def reindex!
        # TODO: Denne path skal kunne konfigureres. Brug evt. dry-configurable.
        index.add_documents(
          JSON.parse(File.read(Kommandant.config.commands_path))
        )
      end

      def search(query)
        result = index.search(query)["hits"]

        result.map do |command|
          new(**command.symbolize_keys)
        end
      end

      def find(id)
        search(id).find { |command| command.id == id }
      end

      def index
        client.index("commands")
      end

      def client
        MeiliSearch::Rails.client
      end
    end

    def initialize(id:, icon:, path:, http_method:, resource_class: nil, redirect_path: nil, text_keys: [], admin_only: false, translations: {})
      @id = id
      @icon = icon
      @path = path
      @http_method = http_method
      @resource_class = resource_class
      @redirect_path = redirect_path
      @text_keys = text_keys
      @admin_only = admin_only
      @translator = I18n::Backend::KeyValue.new({})
      translations.each_pair do |locale, data|
        @translator.store_translations(locale, data)
      end
    end

    def ==(other)
      instance_variables.all? do |ivar|
        instance_variable_get(ivar) == other.instance_variable_get(ivar)
      end
    end

    attr_reader :id, :icon, :path, :http_method, :resource_class, :redirect_path, :text_keys, :translator

    def name
      translator.translate(I18n.locale, "name")
    end

    def placeholder
      return unless translator.exists?(I18n.locale, "placeholder")

      translator.translate(I18n.locale, "placeholder")
    end

    def admin_only?
      admin_only
    end

    private

    attr_reader :admin_only
  end
end
