library(shiny)
library(text2vec)
library(tm)
library(randomForest)

# Função para carregar o modelo e o vetor TF-IDF
load_model_and_vectorizer <- function() {
  model <- readRDS("./models/random_forest_model.rds")
  vectorizer <- readRDS("./models/tfidf_vectorizer.rds")
  list(model = model, vectorizer = vectorizer)
}

# Função para fazer a previsão
make_prediction <- function(input_text, model, vectorizer) {
  input_text <- iconv(input_text, to = 'ASCII//TRANSLIT')
  
  input_itoken <- itoken(c(input_text), progressbar = FALSE)  
  
  if (length(input_text) == 0 || all(nchar(input_text) == 0)) {
    stop("Entrada de texto vazia! Por favor, forneça um quadrigrama válido.")
  }
  
  input_dtm <- create_dtm(input_itoken, vectorizer)
  
  if (nrow(input_dtm) == 0) {
    stop("Erro: Nenhum termo foi identificado no texto fornecido.")
  }
  
  predicted_label <- predict(model, as.matrix(input_dtm))
  return(as.numeric(predicted_label)) 
}

# Função para mapear o número previsto para o nome da classe
map_prediction_to_label <- function(predicted_label) {
  labels <- c("APRENDIZAGEM", "ENTRETENIMENTO", "ESTÉTICA", "EVASÃO")
  return(labels[predicted_label + 1])  
}

# Carregar o modelo e o vetor TF-IDF ao iniciar o aplicativo
model_data <- load_model_and_vectorizer()

ui <- fluidPage(
  titlePanel("Previsão de Domínio da Experiência de Quadrigramas com Modelo Random Forest"),
  sidebarLayout(
    sidebarPanel(
      textInput("input_text", "Digite o quadrigrama para previsão:", ""),
      actionButton("predict_button", "Prever")
    ),
    mainPanel(
      textOutput(outputId = "prediction_result")
    )
  )
)

server <- function(input, output, session) {
  observeEvent(input$predict_button, {
    if (input$input_text != "") {
      predicted_label <- make_prediction(input$input_text, 
                                         model_data$model, 
                                         model_data$vectorizer)
      
      predicted_class <- map_prediction_to_label(predicted_label)
      
      output$prediction_result <- renderText({
        paste("Domínio da experiência: ", predicted_class)
      })
    }
  })
}

shinyApp(ui, server)
