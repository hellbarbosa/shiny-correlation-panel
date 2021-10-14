library(dplyr)
library(ggplot2)
library(gridExtra)
library(tidyr)
library(reshape2)
library(RColorBrewer)
library(ggrepel)
library(shiny)
library(DT)

pokemon <- read.csv(file = "pokemon.csv")
df <- select(pokemon, name, classfication, hp, weight_kg, height_m, speed, attack, defense, sp_attack, sp_defense, type1, type2, abilities, generation, is_legendary, capture_rate)

fluidPage(
  
  titlePanel('Pokemon Correlation - Shiny Pokedex Explorator'),
  
  sidebarLayout(
    sidebarPanel(
      selectInput('attr1', 'Inform first Attribute (Y-axis)', choices = c("speed", "attack", "defense", "sp_attack", "sp_defense")),
      selectInput('attr2', 'Inform second Attribute (X-axis)', choices = c("speed", "attack", "defense", "sp_attack", "sp_defense"), selected = "attack"),
      radioButtons('leng', label = p("Include legendary Pokemons?"), choices = list("Yes" = 1, "No" = 0), selected = 1),
      sliderInput('gen', 'Starting from generation:', min = min(df$generation), max = max(df$generation), value = 1, step = 1),
      textOutput('text')
    ),
    mainPanel(
      tabsetPanel(
        tabPanel(
          'Correlation',
          plotly::plotlyOutput('plot')
        )
      )
      
    )
  )
  
)
