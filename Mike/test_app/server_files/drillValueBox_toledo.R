
#---------------------------
# UI infoBoxes
#---------------------------
#
# What I did was wrap the standard infoBox function with an additonal div that there allows for modified css 
# (pointer style cursor) and js on click function. For each invo box, specify what dataset you wnat in the modal as an arguement to the onclick function


output$InfoBox_toledo<-renderUI({

  #turn this into a function - paramters include what dataset you want to pull up in modal
  tagList(HTML('<div class="drill_infoBox" onclick= drilltest("proposed") >'),
          HTML('
              <div class="col-sm-12">
                <div class="info-box bg-orange">
                  <span class="info-box-icon-toledo">
                    <img class="img-toledo" src="images/toledo2.png">
                  </span>
                <div class="info-box-content">
                    <center><span class="info-box-text">Click here to submit Proposal</span></center>
                    <span class="info-box-text">Number of Proposals Submitted</span>
                    <span class="info-box-number">1</span>
                    <span class="info-box-text">Total Proposed Dollars</span>
                    <span class="info-box-number">150,000</span>
                </div>
              </div>
            </div>
         '),
  HTML('</div>'))

})

output$InfoBox_funded<-renderUI({

  #turn this into a function - paramters include what dataset you want to pull up in modal
  tagList(HTML('<div class="drill_infoBox" onclick= drilltest("funded") >'),
          HTML('
              <div class="col-sm-12">
                <div class="info-box bg-green">
                  <span class="info-box-icon-toledo">
                    <i class="fa fa-dollar-sign fa-2x img-toledo"></i>
                    
                  </span>
                <div class="info-box-content">
                    <center><span class="info-box-text">Click here to View Accepted Proposals</span></center>
                    <span class="info-box-text">Number of Proposals Funded</span>
                    <span class="info-box-number">0</span>
                    <span class="info-box-text">Total Dollars Reallocated</span>
                    <span class="info-box-number">0</span>
                </div>
              </div>
            </div>
         '),
  HTML('</div>'))

})


#------------------------------
# ObsereEvent and Modal Function
#-----------------------------
#Watches for change on input$shinydrill which is just a random number generated onclick event see app.js drilltest() function
observeEvent(input$shinydrill,{
  
  #also echos back what dataset we want to show in the modal
  #input$shinydrill_dataset is the dataset we want to pull based on what infoBox we clicked
  if (input$shinydrill_dataset=='proposed'){
    
      showModal(dataModal_Proposed())
  }
  
  if (input$shinydrill_dataset=='funded'){
    
      showModal(dataModal_InfoBox(title=paste('Complete data set for ',input$shinydrill_dataset,sep='')))
  }
  
})



dataModal_Proposed<-function(title='Submit Proposal'){
  
  modalDialog(title=HTML(paste('<center><h3>',title,'</h3></center>')),size='l',
    
              fluidRow(column(6,textInput('companyname','Company Name',width='100%'))),
              fluidRow(column(6,textInput('ContactName','Contact: Name',width='100%')),
                       column(6,textInput('Contactemail','Contact: email',width='100%'))),
              fluidRow(column(6,textInput('TargetProgram','City Program of Interest',width='100%')),
                       column(6,selectInput('PartnershipType','Partnership Type (select all that apply)',choices=c('Public Private','Outsource Programs','New Program'),multiple=T,width='100%'))),
              
              textareaInput('ProjectDescription','Description', value="Please enter brief description", rows=5, columns=100),
                        
              footer = tagList(
                modalButton("Submit"),
                modalButton("Dismiss"))
    )
}

#**************************************************
# Funded Modal projects summary
#***************************************************
dataModal_Funded<-function(title='Summary of Funded Proposals'){
  
  modalDialog(title=HTML(paste('<center><h3>',title,'</h3></center>')),size='l',
    
              h4('Table of Funded Propsosals to go here'),
                        
              footer = tagList(
                
                modalButton("Dismiss"))
    )
}

 create_IDstring<-function(numeric_vector){
  
  if (length(numeric_vector)==0)(return(NULL))
  
  out<-NULL
  out<-paste("('",numeric_vector[1],sep='')
  if (length(numeric_vector)>1){
    for (i in 2:length(numeric_vector)){
      out<-paste(out,"','",numeric_vector[i],sep='')
      
    }
  }
  out<-paste(out,"')",sep='')
  
 }
 
 
textareaInput <- function(inputID, label, value="please comment", rows=5, columns=100) {
  HTML(paste0('<div class="form-group shiny-input-container">
    <div class="forminput"><label for="', inputID, '">', label,'</label></div>
    <textarea id="', inputID, '" rows="', rows,'" cols="',
    columns,'">', value, '</textarea></div>'))
}

#-----------------------------------------------
# Server side outputs for form
#-----------------------------------------------


#-------------------------------------------
# DT for Modal
#--------------------------------------------
#Dynamic Data Table for info boxes - listens to input$shinydrill_dataset to pick the data for the modal
# output$testInfoBox_DT<-DT::renderDataTable({
#   df<-NULL
#   if (input$shinydrill_dataset=='mtcars')(df<-mtcars)
#   if (input$shinydrill_dataset=='iris')(df<-iris)
#   if(is.null(df))(return(NULL))
#   datatable(df)
#   
#   
# })

