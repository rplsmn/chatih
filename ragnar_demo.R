base_url <- "https://r4ds.hadley.nz"
pages <- ragnar_find_links(base_url, children_only = TRUE)

store_location <- here::here("_solutions/16_rag/r4ds.ragnar.duckdb")

store <- ragnar_store_create(
  store_location,
  title = "R for Data Science",
  # Need to start over? Set `overwrite = TRUE`.
  # overwrite = TRUE,
  embed = \(x) embed_openai(x, model = "text-embedding-3-small")
)

cli::cli_progress_bar(total = length(pages))
for (page in pages) {
  cli::cli_progress_update(status = page)
  chunks <- page |> read_as_markdown() |> markdown_chunk()
  ragnar_store_insert(store, chunks)
}
cli::cli_progress_done()

ragnar_store_build_index(store)

# chat to build

ragnar_register_tool_retrieve(chat, store, top_k = 10)
