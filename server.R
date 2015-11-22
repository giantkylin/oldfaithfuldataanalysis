
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
library(caret)
data("faithful")

palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

shinyServer(function(input, output) {
  
  xrange <- reactive({
    if (input$`plot-range` == "Full") {
      c(0, 6)
    } else if (input$`plot-range` == '1st-cluster'){
      c(1.5, 2.5)
    } else if (input$`plot-range` == '2nd-cluster'){
      c(3.5, 5.5)
    }
  })

  yrange <- reactive({
    if (input$`plot-range` == "Full") {
      c(35, 105)
    } else if (input$`plot-range` == '1st-cluster'){
      c(35, 75)
    } else if (input$`plot-range` == '2nd-cluster'){
      c(55, 105)
    }
  })
  
  trainFaith <- reactive({
    inTrain <- createDataPartition(faithful$waiting, p = input$dataslice/100.0, list = FALSE)
    faithful[inTrain,]
  })

  testFaith <- reactive({
    inTrain <- createDataPartition(faithful$waiting, p = input$dataslice/100.0, list = FALSE)
    faithful[-inTrain,]
  })
  
  modelFit <- reactive({
    train(eruptions ~ waiting, data = trainFaith(), method = "lm")
  })
  
  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    reactive({})
    x    <- faithful[, 1]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white',
         xlab = "Duration (minutes)",
         main = "Geyser eruption duration"
         )
  })
  
  output$clustPlot <- renderPlot({
    
    clusters <- kmeans(faithful, input$clusters)
    
    #par(mar = c(5.1, 4.1, 0, 1))
    plot(faithful,
         col = clusters$cluster,
         pch = 20, cex = 3, main = "Relation between wait and erupt duration")
    points(clusters$centers, pch = 4, cex = 4, lwd = 4)
  })
  
  output$densPlot <- renderPlot({
    ggplot(faithful, aes(eruptions, waiting)) + geom_point() + geom_density2d() +
      ggtitle("Density plot of data") + xlim(xrange()) + ylim(yrange())
  })
  
  output$regresstrainPlot <- renderPlot({
    plot(trainFaith()$waiting, trainFaith()$eruptions, pch=19, col='blue',
         xlab='Waiting', ylab='Duration', main = 'Model Training')
    lines(trainFaith()$waiting, predict(modelFit()), lwd=3)
  })

  output$regresstestPlot <- renderPlot({
    plot(testFaith()$waiting, testFaith()$eruptions, pch=19, col='red',
         xlab='Waiting', ylab='Duration', main = 'Model Testing')
    prediction <- predict(modelFit(), newdata=testFaith())
    lines(testFaith()$waiting, prediction, lwd=3)
  })
  
  output$residualPlot <- renderPlot({
    prediction <- predict(modelFit(), newdata=testFaith())
    plot(modelFit()$finalModel)    
  })
  
  output$predicted <-  renderPrint({
    newInput <- as.data.frame(input$`predict-waiting`)
    colnames(newInput) <- c("waiting") 
    predict(modelFit(), newdata=newInput)
  })
})
