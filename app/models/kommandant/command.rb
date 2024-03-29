module Kommandant
  class Command
    class << self
      def reindex!
        index.add_documents(
          JSON.parse(File.read(Kommandant.config.commands_path))
        )
      end

      def remove_from_index!
        index.delete_all_documents!
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

      def all
        JSON.parse(File.read(Kommandant.config.commands_path)).map do |hash|
          Kommandant::Command.new(**hash.symbolize_keys)
        end
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

    attr_reader :id, :path, :http_method, :resource_class, :redirect_path, :text_keys, :translator

    def name
      return "no translation for #{I18n.locale}.name in Meilisearch" unless translator.exists?(I18n.locale, "name")

      translator.translate(I18n.locale, "name")
    end

    def placeholder
      return unless translator.exists?(I18n.locale, "placeholder")

      translator.translate(I18n.locale, "placeholder")
    end

    def admin_only?
      admin_only
    end

    def icon?
      icon.present?
    end

    def icon
      @icon.to_s.dasherize
    end

    private

    attr_reader :admin_only
  end
end
