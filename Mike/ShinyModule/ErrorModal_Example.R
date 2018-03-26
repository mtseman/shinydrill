library(shiny)
library(shinyjs)
library(shinydashboard)
library(DT)
library(devtools)
library(shinyBS)
#install_github('mtseman/shinyModals',force=T)
#library(shinyModals)

# ErrorModal_UI<-function(id,label='Go'){
#
#     ns<-NS(id)
#
#     tagList(
#
#        actionButton(ns('Robust_Do'),label=label)
#
#
#
#     )
#
# }
#
# ErrorModal<-function(input,output,session,title="Error",subtitle=NULL,message='Sorry, an error has occured',try_this){
#
#   values<-reactiveValues(clicks=0)
#
#   #ObserveEvent on Action button. Run "try_this" and toggle Modal if there is an error
#   observeEvent(input$Robust_Do,{
#
#     robust_do(try_this,subtitle=subtitle,message=message)
#
#     values$clicks<-values$clicks+1
#   })
#
#
#   #*************************************************************************************************************
#   #Wrapper on the tryCatch function that also takes a message and subtitle parameter to pass along to the modal
#   #**************************************************************************************************************
#     #Function that takes a try function and if error displays a message in a modal
#     robust_do<-function(try_this,message=NULL,subtitle=NULL){
#
#
#         Dialog_Error <- function(title='Error',message=NULL,id='shiny-modal',color='red',subtitle='Sorry an error has occured, please try again.') {
#
#             HTML(paste('<div style="margin-top:50px;"></div><div class="modal sbs-modal fade" id="',id,'" tabindex="-1" data-sbs-trigger="tabBut">
#               <div class="modal-dialog modal-lg">
#                 <div class="modal-content">
#                   <div class="modal-header">
#                     <button type="button" class="close" data-dismiss="modal">
#                       <span>&times;</span>
#                     </button>
#                     <h4 class="modal-title"><div style="color:',color,';"><h3><b><center>',title,'</center></h3></b></div></h4>
#                   </div>
#                   <div class="modal-body">
#                     <h4><center>',subtitle,'</center></h4><hr>
#                     <p>',message,'<p>
#                   </div>
#                   <div class="modal-footer">
#                     <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
#                   </div>
#                 </div>
#               </div>
#             </div>
#              <script>$("#shiny-modal").modal().focus();</script>',sep=''))
#
#           }
#
#
#
#         robust_do<-tryCatch(try_this,
#                                 warning=function(w){try_this},
#                                 error=function(e){
#
#                                     showModal(Dialog_Error())
#
#
#                                 }
#         )
#
#     }
#
#
#
#   return(reactive(values$clicks))
# }

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


