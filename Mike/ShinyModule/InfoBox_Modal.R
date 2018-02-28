library(shiny)
library(shinyjs)
library(shinydashboard)

InfoBoxModal_UI<-function(id){
    
    ns<-NS(id)
    
    tagList(
      useShinyjs(),
      
      tags$div(id=ns("box1"),style="cursor:pointer;",
        
        infoBox("Average mpg of mtcars", value=20.09,icon = icon('car'), color = "blue", width = 4,fill=T,href = NULL)
      ))
    
  
} 

InfoBoxModal<-function(input,output,session,...){ 
  
  
    onclick("box1",showModal(dataModal_InfoBox(title=paste('Complete data set for ',"mtcars",sep=''))))
                                            
    dataModal_InfoBox<-function(title='Complete Dataset for mtcars'){
      
      modalDialog(title=HTML(paste('<center><h3>',title,'</h3></center>')),size='l',
        
                 
                  ...
                            
      
        )
    }
}

ui<-dashboardPage(
  
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
      InfoBoxModal_UI("InfoBox")
      
      fluidRow(column(12,h3('Another info box we can click on, we can add icons and colors as parameters for the shiny module, but for now its the same')))
      fluidRow(column(12,h3('But, The nice thing is it is a function that can be used over and over, adds click-abilty to value box and uses ... so modal can be whatever elements user wishes')))
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


