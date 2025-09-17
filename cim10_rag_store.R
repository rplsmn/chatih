library(ragnar)
# cim10_app <- readRDS("data/cim10_app.rds")
# cim_10_categories <- readRDS("data/cim10_categories.rds")

path_pdf <- here::here("data/cim10_pdf_demo.pdf")
pages <- read_as_markdown(path_pdf)
# Alternative with pdftools
# pages2 <- pdftools::pdf_text(path_pdf)
chunks <- markdown_chunk(pages)

store_location <- here::here("cim10.ragnar.duckdb")

store <- ragnar_store_create(
  store_location,
  title = "CIM10 FR PMSI",
  overwrite = TRUE,
  # embed = NULL,
  embed = \(x) embed_openai(x, model = "text-embedding-3-small"),
  # embed = \(x) embed_openai(x, model = "text-embedding-3-large"),
  # version = 2L,
  # version = 1L
)

# pbar <- cli::cli_progress_bar(total = length(pages)))
# purrr::walk(
#   pages,
#   .f = \(page){
#     cli::cli_progress_update(status = page, id = pbar)
#     ragnar_store_insert(store, page$chunks)
#   }
# )
# cli::cli_progress_done()

ragnar_store_insert(store, chunks)

ragnar_store_build_index(store)

# test it

ragnar_retrieve(store, "diabete", top_k = 3) |> dplyr::pull(text)
ragnar_retrieve_vss(store, "diabete", top_k = 5)
ragnar_retrieve_bm25(store, "diabete", top_k = 5)

chat <- ellmer::chat(
  name = "openai/gpt-4.1-nano",
  system_prompt = r"--(
You are an expert at CIM10 FR. The user will ask you to build lists of CIM10 codes.
The user will mention diseases, conditions, symptoms, or other medical terms.
Your job is to provide accurate and relevant CIM10 codes based on the user's input.

Before responding, retrieve relevant material from the knowledge store. Quote or
paraphrase passages, clearly marking your own words versus the source. Provide a
working link for every source you cite.
  )--"
)

ragnar_register_tool_retrieve(chat, store, top_k = 5, deoverlap = TRUE)
ellmer::live_browser(chat)
