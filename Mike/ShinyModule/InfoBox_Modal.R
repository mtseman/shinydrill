library(shiny)
library(shinyjs)
library(shinydashboard)
install_github('shinyModals','mtseman')



ui<-dashboardPage(
  
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
    
      fluidRow(column(12,h3('Here is example of clickable infobox. It uses shinyjs for the onclick event and has been turned into a shiny Module'))),
      InfoBoxModal_UI("InfoBox"),
      
      fluidRow(column(12,h3('Another info box we can click on, we can add icons and colors as parameters for the shiny module, but for now its the same'))),
      fluidRow(column(12,h3('But, The nice thing is it is a function that can be used over and over to create more boxes. A nice feature is the function allows for arbitary UI elements to be displayed in the modal. You pass a tagList of the things you want displayed.'))),
      InfoBoxModal_UI("InfoBox2")
      
      
      
      
  )
)

server<-function(input,output,session){
  
  callModule(InfoBoxModal,"InfoBox",
             #The module can take in a tagList of elements to be displayed when you click the box
             tagList(fluidRow(column(6,h3('List of Stuff for MOdal')),
                              column(6,h4('More Stuff'))),
                     DT::dataTableOutput('testInfoBox_DT'),
                     hr(),
                     p('the final word')
                    
                     ))
  
   callModule(InfoBoxModal,"InfoBox2",
             #The module can take in a tagList of elements to be displayed when you click the box
             tagList(h2('Hello!')
                    
                     ))
  
  
  output$testInfoBox_DT<-DT::renderDataTable({
      df<-mtcars
      datatable(df)
  })
  
}

shinyApp(ui,server)


