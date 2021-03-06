# ui.R

#AD <- read.csv("All_Data_03.05.csv", header=TRUE)
#BM <- .0084
AD <- read.csv("All_Data_04.06.csv", header=TRUE)

clients <- as.matrix(unique(AD$client))
clients <- sort(clients)
verticals <- as.matrix(unique(AD$vertical))
imps <- AD$impressions
linkImps <- AD$impressions [AD$link == "1"]
RTs <- AD$retweets
replies <- AD$replies
favs <- AD$favorites
clicks <- AD$url.clicks
engmnt <- clicks + favs + replies + RTs
overallER <- sum(engmnt)/sum(imps)
overallCTR <- sum(clicks)/sum(linkImps)

shinyUI(fluidPage(
  titlePanel("Insightpool SI tool (by Vertical)"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Enter in the appropriate information below. The chart to the right will display the probability of meeting or exceeding the specified benchmark:"),
    
      selectInput("vertical", 
                  label = "Choose vertical",
                  choices = c(sort(verticals), "OVERALL"),
                  selected = verticals[1]),
  
      selectInput("goal", 
                  label = "Choose goal",
                  choices = c("", "Engagement Rate", "CTR"),
                  selected = "Engagement Rate"),
            
      numericInput("benchmark", 
                   label = "Enter benchmark",
                   value = .0085, step = .001),
      
      submitButton("submit")
      #actionButton("submit", label = "Submit, yo")
            
       ),
    
    mainPanel(
  
   
      tableOutput("table"),
      tableOutput("refTable"),
      plotOutput("plot1")
      
            
            )
  )
))