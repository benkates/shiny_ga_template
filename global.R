#load libraries
#note: use library() funs and not pacman if using shinyapps.io
if (!require(pacman)) install.packages('pacman')
pacman::p_load(
  shiny,
  shinydashboard,
  shinydashboardPlus,
  scales,
  shinyjs,
  googleAnalyticsR,
  googleAuthR,
  data.table,
  fontawesome,
  tidyverse
)

#set client ID + secret
gar_set_client(
  web_json = "client-web-id.json",
  scopes = c(
    "https://www.googleapis.com/auth/analytics",
    "https://www.googleapis.com/auth/analytics.readonly"
  )
)