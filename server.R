library(shiny)
library(dplyr)
library(ggplot2)
library(gapminder)

shinyServer(function(input, output) {
  output$emissionsPlot <- renderPlot({
    # Filter data for selected country and year range
    data <- gapminder %>%
      filter(country == input$country, year >= input$year_range[1], year <= input$year_range[2]) %>%
      select(year, co2 = gdpPercap) # Using gdpPercap as proxy for CO2 emissions
    
    # Simulate CO2 data
    data$co2 <- data$co2 / 1000 + rnorm(nrow(data), mean = 0, sd = 0.5)
    
    # Create future years for prediction
    future_years <- data.frame(year = seq(max(data$year) + 1, max(data$year) + 10))
    
    # Simple linear model for prediction
    model <- lm(co2 ~ year, data = data)
    future_years$co2 <- predict(model, newdata = future_years)
    
    # Combine historical and predicted data
    data$type <- "Historical"
    future_years$type <- "Predicted"
    plot_data <- rbind(data, future_years)
    
    # Plot
    ggplot(plot_data, aes(x = year, y = co2, color = type)) +
      geom_line() +
      geom_point(data = data, size = 3) +
      labs(title = paste("CO2 Emissions for", input$country),
           x = "Year", y = "CO2 Emissions (Metric Tons per Capita)") +
      scale_color_manual(values = c("Historical" = "blue", "Predicted" = "red")) +
      theme_minimal()
  })
})