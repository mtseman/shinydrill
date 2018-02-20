library(shiny)
library(shinydashboard)
#--------------------------------------------------------------
# Basic navbar bag with tabs for testing different drill downs
#---------------------------------------------------------------

navbarPage("Shiny Drill",
  
  header=tags$head(HTML('
    <!-- Shiny dashboard and admin LTE styles and js -->
    <link href="css/AdminLTE.min.css" rel="stylesheet">
    <link href="css/_all-skins.min.css" rel="stylesheet">
    <link href="css/shinydashboard.css" rel="stylesheet">
    <link href="css/app.css" rel="stylesheet">
    <script src="js/app.min.js"></script>
    ')
  ),
                   
  tabPanel("ValueBox",
    source("./ui_files/drillValueBox_UI.R",local=T)$value
  ),
  
  tabPanel("Pie"),
  
  tabPanel("BarChart"),
  
  footer=tags$script(src ="js/app.js")
  
)
