#Libraries
library(shiny)
library(rCharts)

ui <- fluidPage(
  titlePanel("Predict child's height"),
  helpText("This tiny application uses famous data from",  
           a(href="https://en.wikipedia.org/wiki/Francis_Galton", "Francis Galton"),
           "to predict child's height from parent's height"),
  helpText("Data was found from source:"),
  helpText(a(href="http://blog.yhathq.com/static/misc/galton.csv", "http://blog.yhathq.com/static/misc/galton.csv")),

  sidebarLayout(
    sidebarPanel(
      h2('Galton: Predict child\'s heigth'),
      helpText("You can choose the parent's height with the slider. On the right you can see the plot of points of",
               "the used data, the regression line calculated with linear model of data and point of recent data (black point)"),

      h4('Predict child\'s height from parent\'s height'),
      helpText(""),
      sliderInput(inputId = 'userParentHeight', label = "Give parent's height", min = 150.0, max = 210.0, step = 0.5, value = 160.0)

      
    ),
    mainPanel(
      showOutput('childHeightPlot', lib = 'polycharts'),
      h3(strong(textOutput('prediction')))
    )
  )
)