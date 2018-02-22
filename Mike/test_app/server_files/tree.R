output$tree<-renderCollapsibleTree({
  
  results<-read.csv('./data/Boise_results.csv')
  programs<-read.csv('./data/Boise_inventory.csv')
  
  Boise<-merge(results,programs[c('ProgramNumber','Department','Program','Description')],by='ProgramNumber')
  Boise<-Boise[order(Boise$Type,-Boise$Score),]
  Boise$Notes<-as.character(Boise$Notes)
  Boise[is.na(Boise$Notes),'Notes']<-'no notes'
  
  
  tree<-collapsibleTree(
            Boise,
            hierarchy = c("Result", "Score", "Department","Program"),
            width=800,
            inputId = "node"
          )
  
  
  
})

#output$str <- renderPrint((input$node))

observeEvent(input$node,{
  
  #Show modal if we are at the bottom level
  if(is.element(names(input$node),c('Program'))){
    
    results<-read.csv('./data/Boise_results.csv')
    programs<-read.csv('./data/Boise_inventory.csv')
    
    Boise<-merge(results,programs[c('ProgramNumber','Department','Program','Description')],by='ProgramNumber')
    Boise<-Boise[order(Boise$Type,-Boise$Score),]
    Boise$Notes<-as.character(Boise$Notes)
    Boise[is.na(Boise$Notes),'Notes']<-'no notes'
    
    df<-Boise
    df<-df[df$Department==input$node$Department,]
    df<-df[df$Program==input$node$Program,]
    
    description<-df[1,'Description']
    
    showModal(dataModal_Tree(title=input$node$Program,description))
    
  }
  
  
})

dataModal_Tree<-function(title='Submit Proposal',description){
  
  modalDialog(title=HTML(paste('<center><h3>',title,'</h3></center>')),size='l',
            
              HTML(paste('<p><strong>Program Description - </strong>',description,'</p>',sep='')),
              hr(),
              
             
                        
              footer = tagList(
               
                modalButton("Dismiss"))
    )
}