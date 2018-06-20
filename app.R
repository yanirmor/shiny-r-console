# package ----
library(shiny)

# ui -----
ui <- fluidPage(
  # set up -----
  title = "Shiny R Console",
  theme = "style.css",
  tags$head(tags$script(src = "script.js")),
  h1("Shiny R Console"),
  h5("Created by Yanir Mor © 2018"),
  fluidRow(column(width = 10, offset = 1, hr())),
  
  # input -----
  fluidRow(column(width = 6, offset = 3, textInput(
    inputId = "command", 
    label = NULL,
    placeholder = "Enter your R command here",
    width = "100%"
  ))),
  
  fluidRow(
    column(width = 2, offset = 4, actionButton(
      inputId = "run",
      label = "Run",
      width = "100%"
    )),
    column(width = 2, actionButton(
      inputId = "clear",
      label = "Clear",
      width = "100%"
    ))
  ),
  br(),
  
  # output -----
  fluidRow(column(width = 6, offset = 3, verbatimTextOutput(
    outputId = "console"
  )))
)

# server -----
server <- function(input, output, session) {
  # initialize -----
  console <- reactiveVal(value = " ")

  # run -----
  observeEvent(input$run, {
    log <- try(expr = {
      paste((eval(parse(text = input$command))), collapse = " ")
    })
    
    console(paste(">", input$command, "\n", log, "\n\n", console(), "\n"))
    updateTextInput(session = session, inputId = "command", value = "")
  })
  
  # render -----
  output$console <- renderText(console())
  
  # clear ----
  observeEvent(input$clear, console(" "))
}

# run app -----
shinyApp(ui = ui, server = server)
