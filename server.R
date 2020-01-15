server <- function(input, output, session) {
  
  #get auth token after login
  access_token <- callModule(googleAuth,
                             "auth",
                             login_text = HTML(fa("google",fill="white"),"&nbsp;&nbsp;Sign in with Google"))

  #set reactive variable to user's accounts/properties/views
  ga_accounts <- reactive({
    req(access_token())
    with_shiny(ga_account_list, shiny_access_token = access_token())
  })

  #populate dropdown with above data
  selected_id <- callModule(authDropdown, "authMenu", ga.table = ga_accounts)
  
  #set reative variable to user's segments
  ga_segments <- reactive({
    req(access_token())
    with_shiny(ga_segment_list, shiny_access_token = access_token())
  })

  #update segment dropdown with segments available
  observe({
    req(ga_segments())
    ga_segments <- ga_segments()
    seg_choices <- structure(as.character(ga_segments$id),
                             names = as.character(ga_segments$name))
    
    updateSelectInput(session,"segmentSelect",
                      label = "Select segment (optional)",
                      choices = seg_choices,
                      selected = "-1")
  })
  
  #set reactive variable to selected segment ID
  selected_ga_segment_id <- eventReactive(input$segmentSelect,{
    req(ga_segments())
    paste0("gaid::",input$segmentSelect)
  })

  #set reactive variable to selected segment name
  selected_ga_segment_name <- eventReactive(input$segmentSelect,{
    req(ga_segments())
    ga_segments <- ga_segments()
    selected_seg <- as.character(input$segmentSelect)
    as.character(ga_segments[ga_segments$id == selected_seg,]$name)
  })
  
  #set reactive variable to selected date range
  date_range <- reactive({
    req(input$dateRange)
    input$dateRange
  })
  
  #query data
  ga_data <- eventReactive(input$loadDataGABtn,{
    req(selected_ga_segment_id())
    selected_id <- selected_id()
    sdate <- date_range()[1]
    edate <- date_range()[2]
    selected_ga_segment_id <- selected_ga_segment_id()
    selected_ga_segment_name <- selected_ga_segment_name()
    seg_obj <- segment_ga4("Segment", segment_id = selected_ga_segment_id)

    fc <- filter_clause_ga4(list(dim_filter("country","EXACT","United States")))

    data <- with_shiny(
    google_analytics,
     viewId = selected_id,
     segments = seg_obj,
     date_range = c(sdate,edate),
     dimensions = c("region","city"),
     metrics = c("sessions"),
     max = -1,
     dim_filters = fc,
     anti_sample = T,
    shiny_access_token = access_token()
    )

  })
  
  #render snapshot of raw data
  output$rawDataTable <- renderTable({
    ga_data <- ga_data()
    ga_data %>% 
      select(region,city,sessions) %>% 
      arrange(desc(sessions)) %>% 
      head(15) %>% 
      mutate(sessions = scales::comma(sessions))
  })
 
  
}