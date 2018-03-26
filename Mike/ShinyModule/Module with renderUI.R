#***********************************************
# Example from 
# https://shiny.rstudio.com/articles/modules.html
#******************************************************
columnChooserUI <- function(id) {
  ns <- NS(id)
  uiOutput(ns("controls"))
}

columnChooser <- function(input, output, session, data) {
  output$controls <- renderUI({
    ns <- session$ns
    selectInput(ns("col"), "Columns", names(data), multiple = TRUE)
  })

  
  return(reactive({
    validate(need(input$col, FALSE))
    data[,input$col]
  }))
}
#*******************************************************************

ui <- fluidPage(
 
  fileInput('datafile',label=NULL),
  textOutput('dataset_rows'),
  hr(),
  columnChooserUI("chooser"),
  uiOutput('column_selected')
  
 
)

server <- function(input, output, session) {
  
  


  dataset<-reactive({
    if(is.null(input$datafile))(return(NULL))
    return(read.csv(input$datafile$datapath,colClasses = 'character',header=T))
  })
  
   output$dataset_rows<-renderPrint({
    if(is.null(dataset()))(return(NULL))
    nrow(dataset())
  })
  
  #Call Module, return a reactive on selected column in upload file
  observeEvent(dataset(),{
  data_column <- callModule(columnChooser, "chooser",data=dataset())
  })
  
    
  output$column_selected<-renderUI({
    #I thought this should render the text based on the choice made from the module, but doesn't seem to work ??
    #browser()
    return(h2(colnames(data_column())))
    
  })
  
 
    
    
}
  


shinyApp(ui, server)
