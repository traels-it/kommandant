class Post < ApplicationRecord
  include MeiliSearch::Rails

  meilisearch do
    attribute :id
    attribute :name
  end
end
