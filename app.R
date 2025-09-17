library(shiny)
library(bslib)
library(beepr)
library(ellmer)
library(shinychat)
library(querychat)

# Tools ------------------------------------------------------------------------
# swap to appropriate data
demo_data <- mtcars

# UI ---------------------------------------------------------------------------

ui <- page_fillable(
  card(
    fill = FALSE,
    max_height = "400px",
    full_screen = TRUE,
    card_body(
      padding = 0,
      navset_card_underline(
        nav_spacer(),
        nav_panel(
          "SQL",
          icon = fontawesome::fa_i("terminal"),
          uiOutput("ui_sql")
        )
      )
    )
  ),
  chat_mod_ui("chat")
)
# Server -----------------------------------------------------------------------

server <- function(input, output, session) {
  chat_client <- chat_anthropic(
    model = "claude-sonnet-4-20250514",
    system_prompt = interpolate_file(
      here::here("prompt.md")
    )
  )

  chat <- chat_mod_server("chat", chat_client)

  output$ui_sql <- renderUI({
    sql <- NULL # recupérer ici le SQL poussé par chat
    if (!isTruthy(sql)) {
      sql <- "SELECT * FROM demo_data"
    }
    HTML(paste0("<pre><code>", sql, "</code></pre>"))
  })
}

shinyApp(ui, server)
