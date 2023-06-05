library(shiny)
library(shinydashboard)

data <- read.csv("cleaned_dataset_disney.csv")

# Remove specified attributes
data <- data[, !(names(data) %in% c("imdb_id", "released_at", "added_at"))]

shinyUI(
  dashboardPage(
    dashboardHeader(
      title = "Recommendation System for Disney+",
      titleWidth = 650,
      tags$li(class = "dropdown", tags$a(href = "https://github.com/Turjo7/WQD-7001-Group-Project-Data-Product.git", icon("github"), "Source Code", target = "_blank"))
    ),
    dashboardSidebar(
      sidebarMenu(
        id = "sidebar",
        menuItem("Project Info", tabName = "info", icon = icon("database")),
        menuItem("Visualization", tabName = "visual", icon = icon("map"),selected = TRUE),
        menuItem("Recommendation System", tabName = "rs", icon = icon("computer"))
      )
    ),
    dashboardBody(
      tabItem(
        tabName = "info",
        fluidRow(
          column(
            width = 8,
            h2("Project Info"),
            tags$img(src = "banner.jpg", width = 800, height = 520)
          )
        )
      ),
      tabItem(
        tabName = "visual",
        fluidRow(
          column(
            width = 12,
            h2("Visualization"),
            fluidRow(
              column(width = 4, tags$img(src = "1.png", width = 300, height = 200)),
              column(width = 4, tags$img(src = "2.png", width = 300, height = 200)),
              column(width = 4, tags$img(src = "3.png", width = 300, height = 200)),
              column(width = 4, tags$img(src = "4.png", width = 300, height = 200)),
              column(width = 4, tags$img(src = "5.png", width = 300, height = 200)),
              column(width = 4, tags$img(src = "6.png", width = 300, height = 200)),
              column(width = 4, tags$img(src = "7.png", width = 300, height = 200)),
              column(width = 4, tags$img(src = "8.png", width = 300, height = 200)),
              column(width = 4, tags$img(src = "9.png", width = 300, height = 200)),
              column(width = 4, tags$img(src = "10.png", width = 300, height = 200)),
              column(width = 4, tags$img(src = "11.png", width = 300, height = 200)),
              column(width = 4, tags$img(src = "12.png", width = 300, height = 200)),
              column(width = 4, tags$img(src = "13.png", width = 300, height = 200)),
              column(width = 4, tags$img(src = "14.png", width = 300, height = 200)),
              column(width = 4, tags$img(src = "15.png", width = 300, height = 200)),
              column(width = 4, tags$img(src = "16.png", width = 300, height = 200)),
              column(width = 4, tags$img(src = "17.png", width = 300, height = 200)),
              column(width = 4, tags$img(src = "18.png", width = 300, height = 200)),
              column(width = 4, tags$img(src = "19.png", width = 300, height = 200)),
            )
          )
        )
      ),
      tabItem(
        tabName = "rs",
        h2("Recommendation System"),
        # Add content for the Recommendation System tab here
        fluidPage(
          
          
          
          sidebarLayout(
            
            sidebarPanel(
              selectInput("genre", "Genre:", choices = unique(data$genre), multiple = TRUE),
              selectInput("type", "Type:", choices = unique(data$type), multiple = TRUE),
              sliderInput("imdb_rating", "IMDb Rating:", min = 0, max = 10, value = c(0, 10), step = 0.1)
            ),
            
            mainPanel(
              
              mainPanel(
                div(
                  style = "width: 500px; height: 300px; overflow: auto;",
                  tableOutput("moviesTable")
                )
              )
              #tableOutput("predictedVotes")
            )
          )
        )
      )
    )
  )
)
