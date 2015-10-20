# Libraries
library(shiny)
library(ggplot2)
library(dplyr)
library(rCharts)

server <- function(input, output, session) {
  
  #Predict child height from new input
  pred <- reactive({
    return(
      predict(lmGalton,
              newdata = data.frame(
                parent = input$userParentHeight
              ))
    )
  })
  
  # Data model to plot
  ratingByPlatform <- reactive({
    
    dat <- data.frame(child = galton$child, parent = galton$parent)
    dat$fitted <- lmGalton$fitted.values
    return(dat)
    
    })
  
  # Render data model, regression line and current parent/child coordinate from input
  output$childHeightPlot <- renderChart3({
    dat <- ratingByPlatform()
    pred <- data.frame(child=rep(pred(), nrow(dat)), parent= rep(as.numeric(input$userParentHeight), nrow(dat)))
    np <-
      rPlot(
        child ~ parent, color = list(const = '#E91937'), data = dat, type = 'point', opacity = list(const=0.5),
        tooltip = "#! function(item) {return 'Parent height: ' + item.parent + '\\n Child height: ' + item.child} !#"
      )
    
    np$set(width = 600, height = 600)
    np$guides(
      y = list(
        min = min(galton$child), max = max(galton$child), title = 'Child Height in inches'
      ),
      x = list(
        min = min(galton$parent), max = max(galton$parent), title = 'Parent height in inches'
      )
    )
    np$addParams(dom="childHeightPlot")
    np$set(legendPosition = 'bottom')
    np$layer(
      y = 'fitted', copy_layer = T, type = 'line',
      color = list(const = 'grey'), data = dat, size = list(const = 2),
      opacity = list(const=0.5)
    )
    np$layer(
      y = 'child', x = 'parent',
      data = pred, copy_layer=T, type = 'point', color = list(const='black'), size = list(const=5))
    return(np)
  })

  # Render estimated child's height from input
  output$prediction <-
    renderText(paste('Predicted child height: ', round(pred(),2), sep = ''))

}



