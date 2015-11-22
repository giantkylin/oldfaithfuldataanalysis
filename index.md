---
title       : Developing Data Product Project
subtitle    : Simple Data Exploration and Regression on Old Faithful Data
author      : Yue Ke
job         : Data Scientist
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : zenburn      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Overall App Description

1. WebApp is built to show basic data process methods
2. WebApp use interactive plots and models based on Old Faithful data from R package
3. WebApp contains three sections:

  ![WebApp Navigation Bar](./webapptitle.png)
  
  * Data exploration
      + interactive plots to understand data
  * Data Model and Prediction
      + basic linear regression model to fit data using different training/test data slice.
      + Use the model to predict new input data
  * About section also contains brief description and usage guide.

---  

## Data Exploration

Three interactive plots are provided to explore data
  * histogram with interactive bins
  * clusting plot with interactive number of clusters <- example below
  * density plot with three different plot range

<img src="assets/fig/unnamed-chunk-1-1.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" style="display: block; margin: auto;" />

---

## Data Model and Predict
Use linear model to fit and plot with interactive data slicing (60% in example below)

```r
    library(caret)
    inTrain <- createDataPartition(faithful$waiting, p = 0.6, list = FALSE)
    trainFaith <- faithful[inTrain,]
    testFaith <- faithful[-inTrain,]
    modelFit <- train(eruptions ~ waiting, data=trainFaith, method = 'lm')
```

<img src="assets/fig/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />

---

## Conclusion

* Simple WebApp to visulize Old Faithful Geyser data set and explore data modeling
* Show data slicing effect on data modeling and testing
* Simple test with out of sample input to check how well the model is working

WebApp link: 
https://yueke.shinyapps.io/OldFaithfulDataAnalysis

GitHub link:
https://github.com/giantkylin/oldfaithfuldataanalysis