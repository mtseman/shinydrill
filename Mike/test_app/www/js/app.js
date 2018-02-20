/*$(document).ready(function () {
  
$(".drill_infoBox").click(function(){
//do something
  console.log('hello');
});*/

function drilltest(dataset) {
     
       /*alert('Hi! - You clicked me, now send info back to shiny to open modal');*/
       console.log('hello');
       var hello=Math.random();
        

       Shiny.onInputChange("shinydrill_dataset", dataset);
       Shiny.onInputChange("shinydrill", hello);
       
   
}


/*});*/