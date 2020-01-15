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

#set Google Client ID/Secret
options(googleAuthR.webapp.client_id = "YOUR_CLIENT_ID")
options(googleAuthR.webapp.client_secret = "YOUR_CLIENT_SECRET")

options(googleAuthR.client_id = "YOUR_CLIENT_ID")
options(googleAuthR.client_secret = "YOUR_CLIENT_SECRET")

gar_set_client(
  web_json = "client-web-id.json",
  scopes = c(
    "https://www.googleapis.com/auth/analytics",
    "https://www.googleapis.com/auth/analytics.readonly"
  )
)
