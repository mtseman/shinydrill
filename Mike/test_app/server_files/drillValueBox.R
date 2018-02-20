

output$testInfoBox_mtcars<-renderUI({

  #turn this into a function - paramters include what dataset you want to pull up in modal
  tagList(HTML('<div class="drill_infoBox" onclick= drilltest("mtcars") >'),
    infoBox("Average mpg of mtcars", value=20.09,icon = icon('car'), color = "blue", width = 12,fill=T,href = NULL),
  HTML('</div>'))

})

output$testInfoBox_iris<-renderUI({

  #turn this into a function - paramters include what dataset you want to pull up in modal
  tagList(HTML('<div class="drill_infoBox" onclick= drilltest("iris") >'),
    infoBox("Average Sepal Length of iris", value=8.84,icon = icon('leaf'), color = "green", width = 12,fill=T,href = NULL),
  HTML('</div>'))

})




#Watches for change on input$shinydrill which is just a random number generated onclick event see app.js drilltest() function
observeEvent(input$shinydrill,{
  
 
  #also echos back what dataset we want to show in the modal
  #input$shinydrill_dataset is the dataset we want to pull based on what infoBox we clicked
  
    showModal(dataModal_InfoBox(title=paste('Complete data set for ',input$shinydrill_dataset,sep='')))
    
    
  
})

#Dynamic Data Table for info boxes - listens to input$shinydrill_dataset to pick the data for the modal
output$testInfoBox_DT<-DT::renderDataTable({
  
  if (input$shinydrill_dataset=='mtcars')(df<-mtcars)
  if (input$shinydrill_dataset=='iris')(df<-iris)
  
  datatable(df)
  
  
})

dataModal_InfoBox<-function(title='Complete Dataset for mtcars'){
  
  modalDialog(title=HTML(paste('<center><h3>',title,'</h3></center>')),size='l',
    
              
              DT::dataTableOutput('testInfoBox_DT')      
                        
  
    )
}

