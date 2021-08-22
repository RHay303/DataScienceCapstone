suppressPackageStartupMessages(c(
  library(shinythemes),
  library(shiny),
  library(tm),
  library(stringr),
  library(markdown),
  library(stylo)))

#load data files

quadgramData <- readRDS(file="quadgramData.RData")
trigramData <- readRDS(file="trigramData.RData")
bigramData <- readRDS(file="quadgramData.RData")

#clean up text from user input
dataCleaner<-function(text234){
  
  cleanText <- tolower(text234)
  cleanText <- removePunctuation(cleanText)
  cleanText <- removeNumbers(cleanText)
  cleanText <- str_replace_all(cleanText, "[^[:alnum:]]", " ")
  cleanText <- stripWhitespace(cleanText)
  
  return(cleanText)
}

cleanInput <- function(text123){
  
  textInput <- dataCleaner(text123)
  textInput <- txt.to.words.ext(textInput, 
                                "English.all", 
                                preserve.case = TRUE)
  
  return(textInput)
}

#Predict the next work based on pattern found from data files
nextWordPrediction <- function(wordCount,textInput){
  
  #build list of words from user input
  if (wordCount>=3) {
    textInput <- textInput[(wordCount-2):wordCount] 
    
  }
  
  else if(wordCount==2) {
    textInput <- c(NA,textInput)   
  }
  
  else {
    textInput <- c(NA,NA,textInput)
  }
  
  #look for words similar to user input to predict next word
  wordPrediction <- as.character(quadgramData[quadgramData$unigram==textInput[1] & 
                                              quadgramData$bigram==textInput[2] & 
                                              quadgramData$trigram==textInput[3],][1,]$quadgram)
  
  if(is.na(wordPrediction)) {
    wordPrediction1 <- as.character(trigramData[trigramData$unigram==textInput[2] & 
                                                 trigramData$bigram==textInput[3],][1,]$trigram)
    
    if(is.na(wordPrediction)) {
      wordPrediction <- as.character(bigramData[bigramData$unigram==textInput[3],][1,]$bigram)
    }
  }
  
  
  print(wordPrediction)
}