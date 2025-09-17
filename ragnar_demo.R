library(ragnar)
base_url <- "cim10.md"
# pages <- ragnar_find_links(base_url, children_only = TRUE)

store_location <- here::here("cim10.ragnar.duckdb")

store <- ragnar_store_create(
  store_location,
  title = "CIM10 FR PMSI",
  # Need to start over? Set `overwrite = TRUE`.
  overwrite = TRUE,
  embed = \(x) embed_openai(x, model = "text-embedding-3-small")
)

chunks <- base_url |> read_as_markdown() |> markdown_chunk()
ragnar_store_insert(store, chunks)

# cli::cli_progress_bar(total = length(pages))
# for (page in pages) {
#   cli::cli_progress_update(status = page)
#   chunks <- page |> read_as_markdown() |> markdown_chunk()
#   ragnar_store_insert(store, chunks)
# }
# cli::cli_progress_done()

ragnar_store_build_index(store)

# chat to build

chat <- ellmer::chat(
  name = "openai/gpt-4.1-nano",
  system_prompt = r"--(
You are an expert at CIM10 FR

Before responding, retrieve relevant material from the knowledge store. Quote or
paraphrase passages, clearly marking your own words versus the source. Provide a
working link for every source you cite.
  )--"
)

ragnar_register_tool_retrieve(chat, store, top_k = 10)
ellmer::live_browser(chat)
