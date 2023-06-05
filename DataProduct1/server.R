#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(randomForest)
data <- read.csv("cleaned_dataset_disney.csv")

# Remove specified attributes
data <- data[, !(names(data) %in% c("imdb_id", "released_at", "added_at"))]

# Define server logic required to draw a histogram

# Define numerical features
numerical_features <- c("runtime", "imdb_rating", "metascore")

# Define categorical features
categorical_features <- c("genre", "director", "country", "actors")

# Define target variable
target <- "imdb_votes"
shinyServer <- function(input, output) {
  filteredData <- reactive({
    # Filter the data based on the selected genre, type, and IMDb rating range
    filtered <- subset(data, genre %in% input$genre & type %in% input$type & imdb_rating >= input$imdb_rating[1] & imdb_rating <= input$imdb_rating[2])
    
    if (nrow(filtered) == 0) {
      # Display a message when no movies match the selected criteria
      filtered <- data.frame(message = "No movies match the selected criteria.")
    }
    
    filtered
  })
  
  output$moviesTable <- renderTable({
    # Display the filtered data or error message
    filteredData()
  })
  
  output$predictedVotes <- renderTable({
    if (nrow(filteredData()) == 0) {
      # Display an empty table when no movies match the selected criteria
      return(NULL)
    }
    
    # Prepare the data for Random Forest model
    data_rf <- filteredData()
    
    if (nrow(data_rf) > 1) {
      # Convert categorical features to factors
      for (feature in categorical_features) {
        data_rf[[feature]] <- as.factor(data_rf[[feature]])
      }
      
      # Train the Random Forest model
      model <- randomForest(imdb_votes ~ ., data = data_rf[, c(numerical_features, categorical_features, "imdb_votes")])
      
      # Predict imdb_votes for the filtered data
      predictedData <- data.frame(imdb_votes = predict(model, newdata = data_rf))
      
      # Display the predicted imdb_votes
      predictedData
    } else {
      # Display a message when there is only one row in the filtered data
      data.frame(message = "Insufficient data for prediction.")
    }
  })
}
