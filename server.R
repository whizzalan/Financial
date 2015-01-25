library(shiny)
require(ggplot2)
require(dplyr)
require(lazyeval)

# Define a server for the Shiny app
shinyServer(function(input, output) { #,session
  datasetInput <- reactive({
    switch(input$output,
           "MaxPlot" = "max",
           "MinPlot" = "min")
  })
  
  # Fill in the spot we created for a plot
  output$Plot <- renderPlot({
    ## 計算每日最高價
    expr <- interp(quote(ff == gg(ff)),ff=as.name(input$value),gg=as.name(datasetInput()))
    result <- DF %>%
      group_by(date) %>%
      filter( expr) %>%
      select(date,time,OPEN,HIGH,LOW,CLOSE,VOLUME)
  
    expr_ <- interp(quote(f),f=as.name(input$value))
    p <- ggplot(data=result,aes(x=time))
    ## stat="identity" 直接告訴數值,"bin" table結果
    p + geom_bar(stat="bin") + coord_flip()+ggtitle(input$value)
  })
  
})