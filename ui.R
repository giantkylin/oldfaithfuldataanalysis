
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(rCharts)
require(markdown)


shinyUI(
  navbarPage("Old Faithful Geyser Data",
    # multi-page user-interface
    tabPanel("Data Exploration",
             sidebarPanel(
               # Sidebar with a slider input for number of bins
                   sliderInput("bins",
                               "Histogram:",
                               min = 1,
                               max = 50,
                               value = 30),
               # Numeric input for k-means clustering
                   numericInput('clusters', 'Clustering', 2,
                            min = 1, max = 9),
               # Data plot range for density analysis
                   selectizeInput('plot-range','eruption density plot range', 
                                  choices = list('Full', '1st-cluster', '2nd-cluster'))
              ),
             # Show a plot of the generated distribution
             mainPanel(
                plotOutput("distPlot"),
                plotOutput("clustPlot"),
                plotOutput("densPlot")
             )
    ),
    tabPanel("Data Regression and Prediction",
             sidebarPanel(
               # Sidebar with a slider input for number of bins
               sliderInput("dataslice",
                           "Training Data Pct:",
                           min = 10,
                           max = 90,
                           value = 60),
               numericInput('predict-waiting', 'Test wait time', 60,
                            min = 10, max = 100)
              ),
             # Show a plot of the generated distribution
             mainPanel(
               h3('Predicted eruption duration:'),
               verbatimTextOutput("predicted"),
               plotOutput("regresstrainPlot"),
               plotOutput("regresstestPlot"),
               plotOutput("residualPlot")
             )
    ),
    tabPanel("About",
             mainPanel(
               includeMarkdown("about.md")
             )
    )
  )
)
