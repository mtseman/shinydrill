

output$testInfoBox<-renderUI({

  tagList(HTML('<div class="drill_infoBox" onclick= drilltest() >'),
    infoBox("Average mpg of mtcars", value=20.09,icon = icon('car'), color = "blue", width = 4,fill=T,href = NULL),
  HTML('</div>'))

})