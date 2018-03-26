library(shiny)
library(shinyjs)
library(shinydashboard)
library(DT)
library(devtools)
library(shinyBS)
#install package initially and again for updates
#install_github('mtseman/shinyModals',force=T)
library(shinyModals)


ui<-dashboardPage(

  dashboardHeader(
    #tags$head(
      #includeCSS('./app.css')

    #)
  ),
  dashboardSidebar(),
  dashboardBody(


      fluidRow(column(12,h5('There is a data frame with columns "a" and "b", just for this example if you try and select a column other than those it will give an error box. But try an acceptable column and still see an error. It never changes from your first entry, its not reactive(?)'))),
      textInput('col',label='Select This Column'),
      ErrorModal_UI("TryThis_01",label='Try me'),br(),
      textOutput('column_data')




  )
)

server<-function(input,output,session){

  column_select<-function(col){
    df<-data.frame(a=c(1:3),b=c(2:4))
    #browser()

    return(df[,input$col])
  }




  callModule(ErrorModal,"TryThis_01",title="Error",subtitle=NULL,message='Sorry, invalid column selection',try_this=column_select(input$col))





}

shinyApp(ui,server)


