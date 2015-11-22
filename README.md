
# Developing Data Products Project - Old Faithful Data Aanalysis

This application is based on the faithful dataset from R MASS package. Full description of the processing workflow is available on RPubs. Source code is available on the GitHub.

There are two panels on the webpage. One to explore data plotting and the other is fitting a linear regression model based on different training/testing data set slice.

In the data exploration, You can adjust bin number to check event clusing between erupation duration and waiting time. A simple K-means clusing tool is provided to visualize the data clusters. Finnally, we plot the density contour to explore the data centering.

In the data modeling and prediction, a very simple linear regression model is built to estimate the duration and waiting time relation. One can visualzie the residual and variance change with different training and test cases. Finally a straightforward linear model is used to test out of sample cases where a waiting time can be manually entered to predict the corresponding eruption duration.

The project is on Shiny User Showcase Page: https://yueke.shinyapps.io/OldFaithfulDataAnalysis

The sourcecode and related material are on github:
https://github.com/giantkylin/oldfaithfuldataanalysis
