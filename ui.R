suppressPackageStartupMessages(c(
  library(shinythemes),
  library(shiny),
  library(tm),
  library(stringr),
  library(markdown),
  library(stylo)))

shinyUI(fluidPage(
  
  titlePanel("Text Predictor"),
        sidebarPanel(
                     textInput("text",   label = h3("Enter the text:"),
                               value = ),
                     tags$span(style="color:grey",("Only the English language will work."))  
                     
        ),
                   
        mainPanel(
            h4("You  entered:"),
            tags$strong(tags$h3(textOutput("enteredWords")))),
            br(),    
            br(), 
            br(), 
            br(), 
            h4("The next word is predicted to be:"),
            tags$strong(tags$h3(textOutput("predictedWord"))),
                                             
           
)                                           
)
   
                   
                   
                   


