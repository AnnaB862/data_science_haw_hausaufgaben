
# 6. Hausaufgabe, Bruhn, Anna-Katharina

library(e1071)
library(shiny)

# Load the model

model.svm <- readRDS('titanic.svm.rds')

ui <-fluidPage(
  
  titlePanel("Ihre Überlebenschance auf der Titanic?"),
  
  # Sidebar layout with input and output definitions
  sidebarLayout(
    
    
    sidebarPanel(
      
      
      sliderInput("age", "Alter:", 
                  min = 0, max = 100,
                  value = 1),
      
      
      selectInput("sex", selected = NULL, "Geschlecht:", 
                  c("weiblich" = 1, "maennlich" = 0)),
      
      selectInput("pclass", selected = NULL, "Passagierklasse:",
                  c("1" = 1, "2" = 2, "3" = 3)),
      
      actionButton("action", label = "Werde ich überleben?")
      
    ),
    # Main panel for displaying outputs
    
    mainPanel(tableOutput("value1")
    )
  )
)
 
# Define server logic
server <- function(input, output, session ) {
  
  observeEvent(input$action, {
    pclass <- as.numeric(input$pclass)
    sex <- as.numeric(input$sex)
    age <- input$age
    data <- data.frame(pclass,sex,age)
    result <- predict(model.svm, data, probability=TRUE)
    my_result <- data.frame(attr(result, "probabilities"))
    output$value1 <- renderTable(my_result)
    
    }
  )
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
