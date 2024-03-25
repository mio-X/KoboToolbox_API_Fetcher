library(shiny)
library(httr)
library(jsonlite)
library(DT)
library(dplyr)

ui <- fluidPage(
  titlePanel("KoboToolbox API v2 Link Fetcher"),
  sidebarLayout(
    sidebarPanel(
      width = 15,
      selectInput("serverSelect", "Select your Kobo Toolbox Server:", 
                  choices = c("https://eu.kobotoolbox.org", "https://kf.kobotoolbox.org"),
                  selected = "https://kf.kobotoolbox.org"), # Customize your server link
      textInput("formatParameter", "Enter your Kobo Form ID:", "aSScAmYCTjfyo8mVYCf4Pt"),
      actionButton("submit", "Submit"),
      br(),
      
    ),
    mainPanel(
      width = 15,
      wellPanel(
        DTOutput("exportTable"), # Use DTOutput instead of dataTableOutput
        downloadButton("downloadCSV", "Download"),
        br(),
      ),
      wellPanel(
        p(style = "color:#4169E1; font-weight:bold;", "Instructions:"),
        p("1. Select URL of your Kobo Toolbox Server."),
        p("2. Enter your Kobo Form ID in the text box above."),
        p("4. The table will display the exported links."),
        p("5. Use the 'Download' button to download the table data as a CSV file."),
        br(),
        p(style = "color:#4169E1; font-weight:bold;", "Readme:"),
        p("Before you start, you need to enable the 'Anyone can view submissions made to this form' option in the 'Sharing' tab of your KoboToolbox server. This will allow app to access the api links from the server."),
        p("Customize your exported file in the 'Advanced Options' section of the 'Download' tab in KoBoToolbox. Save these settings in KoBoToolbox, and they will be displayed in this app."),
        br(),
        p("To obtain the form ID in KoBoToolbox, simply locate it in the URL after /forms/ when viewing the form details"),
        p("Global KoboToolbox Server: for example, in the URL https://kf.kobotoolbox.org/#/forms/aSScAmYCTjfyo8mVYCf4Pt/summary, the form ID is aSScAmYCTjfyo8mVYCf4Pt."),
        p("European Union KoboToolbox Server: for example, in the URL https://eu.kobotoolbox.org/#/forms/aSScAmYCTjfyo8mVYCf4Pt/summary, the form ID is aSScAmYCTjfyo8mVYCf4Pt."),
        br(),
        p(style = "color:#4169E1; font-weight:bold;", "Disclaimer:"),
        p("This app fetches data from the KoBoToolbox API for informational purposes only. No data is collected or stored in the app. Users are responsible for verifying the accuracy of the data. The developer assumes no liability for the use or interpretation of the fetched data."),
        br(),
        p(style = "color:#4169E1; font-weight:bold;", "Developer:"),
        p("Myo Oo"),
      )
    )
  )
)

server <- function(input, output) {
  observeEvent(input$submit, {
    req(input$formatParameter)
    
    # Construct the URL
    url <- paste0(input$serverSelect, "/api/v2/assets/", input$formatParameter, "/?format=json")
    
    # Fetch data from the API
    response <- GET(url)
    data <- content(response, "text")
    jsonData <- fromJSON(data)
    
    # Extract export settings
    export_settings <- jsonData$export_settings
    
    # Convert to data frame
    export_df <- as.data.frame(export_settings)
    
    # Clean data
    export_df$data_url_csv <- gsub("\\?format=json", "", export_df$data_url_csv)
    export_df$data_url_xlsx <- gsub("\\?format=json", "", export_df$data_url_xlsx)
    export_df$name <- ifelse(is.na(export_df$name), "Default", export_df$name)
    
    # Rename columns and keep only desired columns
    export_df <- export_df %>%
      rename("Export Setting" = name, "CSV" = data_url_csv, "XLSX" = data_url_xlsx) %>%
      select("Export Setting", "CSV", "XLSX")
    
    # Show data in the table
    output$exportTable <- renderDT({
      datatable(export_df)
    })
    
    # Download CSV button handler
    output$downloadCSV <- downloadHandler(
      filename = function() {
        paste("export_data", ".csv", sep = "")
      },
      content = function(file) {
        write.csv(export_df, file)
      }
    )
  })
}

shinyApp(ui = ui, server = server)
