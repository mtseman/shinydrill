library(shiny)
library(shinydashboard)
library(DT)
library(collapsibleTree)

#--------------------------------------------------------------
# Basic navbar bag with tabs for testing different drill downs
#---------------------------------------------------------------

navbarPage('ShinyDrill',
  #h2('hello')
  #include these css and js files so we get the styling of the shinydashboard in a more basic navbarpage.
  header=tags$head(HTML('
    <!-- Shiny dashboard and admin LTE styles and js -->
    <link href="css/AdminLTE.min.css" rel="stylesheet">
    <link href="css/_all-skins.min.css" rel="stylesheet">
    <link href="css/shinydashboard.css" rel="stylesheet">
    <link href="css/app.css" rel="stylesheet">
    <script src="js/app.min.js"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
    ')
  ),

  tabPanel("CollapsibleTree",
    source("./ui_files/tree_UI.R",local=T)$value
  ),
  
  tabPanel("ValueBox",
    source("./ui_files/drillValueBox_UI.R",local=T)$value
  ),

  tabPanel("ValueBox2",
    source("./ui_files/drillValueBox2_UI.R",local=T)$value
  ),

  

  tabPanel("Pie"),

  tabPanel("BarChart"),

  footer=tags$script(src ="js/app.js")
  
)
