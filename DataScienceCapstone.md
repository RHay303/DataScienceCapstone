<style type="text/css">

body, td {
   font-size: 14px;
}
code.r{
  font-size: 20px;
}
pre {
  font-size: 20px
  white-space: pre !important;
  overflow-y: scroll !important;
  max-height: 100vh !important;
  
}
</style>

Data Science Capstone for the John Hopkins Data Science Course through Coursera
========================================================
<h5> author: Rebecca Hay 
date: 8/21/2021</h5>


Project Objective
========================================================

The purpose of this project was to build a program to predict the user's next word.  The predictive model is based on the SwiftKey dataset (http://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip) 

The dataset contain words from news, blogs and twitter so it should contain a broad miz of phrases commonly used.  The model is based on word count and attempt to match the first few words the user enters with the most likely next word based on frequencies found from the SwiftKey dataset.

Project Approach
========================================================
A subset of the SwiftKey data set was sampled.  The data was converted to lowercase, profane words were removed along with special characters and white space.  This data was then tokenized into n-grams.  See this for more info on n-grams (http://en.wikipedia.org/wiki/N-gram).

The n-grams were converted to frequency dictionaries so that the user input could be compared to them to predict the next word.

Sample of Code to Find Prediction Text
========================================================

```r
nextWordPrediction <- function(wordCount,textInput){
  
  #build list of words from user input
  if (wordCount>=3) {textInput <- textInput[(wordCount-2):wordCount]}
  else if(wordCount==2) {textInput <- c(NA,textInput)}
  else {textInput <- c(NA,NA,textInput)}
  
  #look for words similar to user input to predict next word
  wordPrediction <- as.character(quadgramData[quadgramData$unigram==textInput[1] & 
                                              quadgramData$bigram==textInput[2] & 
                                              quadgramData$trigram==textInput[3],][1,]$quadgram)
  
  if(is.na(wordPrediction)) {wordPrediction1 <- as.character(trigramData[trigramData$unigram==textInput[2] & 
                                                 trigramData$bigram==textInput[3],][1,]$trigram)
    
    if(is.na(wordPrediction)) {
      wordPrediction <-as.character(bigramData[bigramData$unigram==textInput[3],][1,]$bigram)}}
  
  print(wordPrediction)
}
```

Shiny App
========================================================
Here's a link to the Shiny app: 

https://rp303.shinyapps.io/test3/

Give it try and see what you think!

The source code can be found at 

https://github.com/RHay303/DataScienceCapstone


Thoughts on Shiny App and Prediction
========================================================
I tried the following phrases and the app predicted the words to the right of the arrow


1.  "I would like to"--> see

    This seems like a reasonable prediction.
    
2.  "Good things"--> i
    
    This doesn't seem like a very good prediction

3.  "It is my senior year of high"--> school
    
    Looks like with more words that the predictions are more accurate.

Conclusions
========================================================
This exercise proves that I was able to build a basic word predictor.  The results are mixed as far how well it works.  I think with more time and better resources I would be able to make it better.

If the user enters more words than a better prediction seems to be found.  This makes sense as there are less frequent word patterns with those combinations.

The predictions would also have better results if model was trained on a larger dataset and run on a more robust computer.  I had to limit the data set due to my computer memory.  I suspect it's better to run on a server and perhaps hire a more experienced data scientist to help out.


