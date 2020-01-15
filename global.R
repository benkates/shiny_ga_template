#load libraries
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(scales)
library(shinyjs)
library(googleAnalyticsR)
library(googleAuthR)
library(data.table)
library(fontawesome)
library(tidyverse)

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