MeiliSearch::Rails.configuration = {
  meilisearch_url: ENV.fetch("MEILI_HTTP_ADDR") { "http://localhost:7700" },
  meilisearch_api_key: ENV.fetch("MEILI_MASTER_KEY") { "MASTER_KEY" },
  per_environment: true
}
