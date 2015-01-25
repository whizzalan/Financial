library(shiny)

# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).

# Define the overall UI
shinyUI(fluidPage(
  titlePanel("Reactivity"),
  sidebarLayout(      
    sidebarPanel(
      selectInput("value" , "Variable:",choices = names_list),
      selectInput("output", "Output:"  ,choices = c("MaxPlot","MinPlot")),
      hr(),
      helpText("XXX")
    ),    
    mainPanel(plotOutput("Plot"))
  )
))