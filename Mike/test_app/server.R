library(shiny)
library(shinydashboard)
library(DT)
library(collapsibleTree)

server <- function(input, output,session) { 
  

  
#---------------------------------------------------------------------------------------------------------------------
# ValueBox - Make a function in our library that creates a clickable valuebox that opens a modal of detailed data table
#----------------------------------------------------------------------------------------------------------------------
source("./server_files/drillValueBox.R",local=T)
  
#---------------------------------------------------------------------------------------------------------------------
# ValueBox - Application
#----------------------------------------------------------------------------------------------------------------------
source("./server_files/drillValueBox_toledo.R",local=T)
  
#---------------------------------------------------------------------------------------------------------------------
# Collapsible Tree
#----------------------------------------------------------------------------------------------------------------------
  
source("./server_files/tree.R",local=T) 
  
}