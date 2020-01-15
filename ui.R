#############################
#HEADER
#############################

header <- dashboardHeader(title = "Shiny GA Template")

favicon <-
    tags$head(tags$link(rel = "shortcut icon", href = "https://rstudio.com/favicon-32x32.png"))

#update page title
update_title <-
    tags$script(HTML("document.title = 'Shiny GA Template';"))

#############################
#SIDEBAR
#############################

sidebar <- dashboardSidebar(sidebarMenu(id = "menuItems",
                                        menuItem(
                                            "Query Data", tabName = "queryData", icon = icon("spinner")
                                        )))

#############################
#QUERY/PREVIEW DATA
#############################

main_tab <- tabItem(
    tabName = "queryData",
    favicon,
    update_title,
    h2("Shiny Google Analytics Template"),
    br(),
    fluidRow(
        box(
            title = "Query data from Google Analytics",
            googleAuthUI("auth"),tags$br(),
            
            authDropdownUI("authMenu"),
            selectizeInput(
                inputId = "segmentSelect",
                label = "Segment (optional)",
                choices = c("All Users")
            ),
            dateRangeInput(
                inputId = "dateRange",
                label = "Date Range Selection",
                start = Sys.Date() - 365,
                end = Sys.Date() - 1
            ),
            actionButton(inputId = "loadDataGABtn", label = "Query Data from GA", icon = icon("download"))
        ),
        box(title = "Raw Data (Top 15)",
            tableOutput("rawDataTable"))
    )
)

#############################
#BUILD
#############################

body <- dashboardBody(tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
),
tabItems(main_tab))

ui <- dashboardPagePlus(header,
                        sidebar,
                        body,
                        useShinyjs()
)
