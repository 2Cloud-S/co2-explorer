library(shiny)
library(dplyr)
library(ggplot2)
library(gapminder)

ui <- fluidPage(
  titlePanel("CO2 Emissions Explorer"),
  tags$p("Author: Afnan Khan", style = "text-align: right; font-style: italic; font-size: 14px; color: #555;"),
  
  sidebarLayout(
    sidebarPanel(
      h3("Welcome to the CO2 Emissions Explorer!"),
      p("This app lets you explore CO2 emissions trends for countries using the gapminder dataset. Select a country to see its emissions over time and a predicted trend for the next 10 years."),
      selectInput("country", "Choose a Country:", choices = unique(gapminder$country)),
      sliderInput("year_range", "Year Range:", min = 1950, max = 2007, value = c(1950, 2007), sep = ""),
      h4("How to Use:"),
      p("1. Select a country from the dropdown menu."),
      p("2. Adjust the year range to focus on specific periods."),
      p("3. View the plot showing historical CO2 emissions and a predicted trend line extended 10 years into the future."),
      p("Data Source: gapminder R package.")
    ),
    
    mainPanel(
      plotOutput("emissionsPlot")
    )
  )
)
