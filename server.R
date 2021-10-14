library(dplyr)
library(ggplot2)
library(gridExtra)
library(tidyr)
library(reshape2)
library(RColorBrewer)
library(ggrepel)
library(shiny)
library(DT)

function(input, output) {
  
  output$text <- renderText({
    paste('You are now comparing ', input$attr1, 'versus ', input$attr2, ' for Pokemons starting from generation', input$gen)
  })
  

  output$plot <- plotly::renderPlotly({
    df %>%
      na.omit() %>%
      filter(generation >= input$gen) %>%
      filter(is_legendary == 0 | is_legendary == input$leng) %>%
      select(attr1 = input$attr1, attr2 = input$attr2, len = input$attr1, name = name) %>%
        ggplot(aes(attr1, attr2))+
        geom_point(aes(color=len, text=name), size = 2, alpha = 0.7)+
        geom_smooth(method = "lm", size=1.5)+
        theme_light()+
        labs(y=paste(input$attr1), x=paste(input$attr2))
  })

}


