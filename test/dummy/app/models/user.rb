class User < ApplicationRecord
  include MeiliSearch::Rails

  meilisearch do
    attribute :id
    attribute :name
  end

  kredis_unique_list :recent_commands, limit: 5
end
