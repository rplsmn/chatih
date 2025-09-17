library(dplyr)
cim10_codes <- readRDS("data/cim10_tidy.rds")
cim10_hiera <- readRDS("data/cim10_h_tidy.rds")

cim10 <-
  cim10_codes |>
  select(code, liblong, hiera) |>
  rename(
    code_description = liblong,
    code_category = hiera
  ) |>
  as_tibble()

cim_10_categories <-
  cim10_hiera |>
  rename(
    code_category_description = lib,
    code_category = hiera,
    code_category_code_start = diag_deb,
    code_category_code_end = diag_fin
  ) |>
  as_tibble()

cim10_app <-
  cim10 |>
  left_join(
    cim_10_categories,
    by = "code_category"
  ) |>
  mutate(
    text = paste(
      "Code : ",
      code,
      "\nCode description :",
      code_description,
      "\nCategory :",
      code_category,
      "\nCategory description : ",
      code_category_description,
      sep = ""
    )
  ) |>
  select(
    code,
    code_category,
    code_category_code_start,
    code_category_code_end,
    text
  )

saveRDS(cim10_app, "data/cim10_app.rds")
saveRDS(cim_10_categories, "data/cim10_categories.rds")
