library(randomForest)
library(caret)
library(readxl)
library(tm)
library(SnowballC)
library(text2vec)

# Carregar base de quadrigramas classificados
df <- read_excel("./src/data/data_set_PEJ.xlsx") 
df$DOMINIO_l <- as.factor(ifelse(df$DOMINIO == "APRENDIZAGEM", 0, 
                                 ifelse(df$DOMINIO == "ENTRETENIMENTO", 1,
                                        ifelse(df$DOMINIO == "ESTETICA", 2, 3))))

# Remover a coluna DOMINIO
df$DOMINIO <- NULL

# Remover acentos
remove_accent <- function(text) {
  iconv(text, to='ASCII//TRANSLIT')
}
df$QUADRIGRAMAS <- sapply(df$QUADRIGRAMAS, remove_accent)

# Dividir a base de dados em treinamento (80%) e teste (20%)
set.seed(40)
train_index <- createDataPartition(df$DOMINIO_l, p=0.8, list=FALSE)
train_data <- df[train_index, ]
test_data <- df[-train_index, ]

# Vetorização dos dados de treinamento usando TF-IDF
it_train <- itoken(train_data$QUADRIGRAMAS, progressbar = FALSE)

# Criar um vocabulário
vocab <- create_vocabulary(it_train)
vectorizer <- vocab_vectorizer(vocab)

# Criar a matriz documento-termo (DTM) para os dados de treinamento
dtm_train <- create_dtm(it_train, vectorizer)

# Aplicar transformação TF-IDF na matriz DTM
tfidf <- TfIdf$new()
dtm_train_tfidf <- fit_transform(dtm_train, tfidf)

# Treinar o modelo Random Forest
rnd_mdl <- randomForest(x = as.matrix(dtm_train_tfidf), y = train_data$DOMINIO_l, 
                        ntree = 1000, mtry = sqrt(ncol(dtm_train_tfidf)), maxnodes = 10)

# Vetorização dos dados de teste
it_test <- itoken(test_data$QUADRIGRAMAS, progressbar = FALSE)
dtm_test <- create_dtm(it_test, vectorizer)

# Transformar a matriz DTM de teste usando o mesmo transformador TF-IDF
dtm_test_tfidf <- transform(dtm_test, tfidf)

# Fazer previsões com o modelo
test_pred <- predict(rnd_mdl, newdata = as.matrix(dtm_test_tfidf))

# Imprimir métricas de avaliação
conf_matrix <- confusionMatrix(test_pred, test_data$DOMINIO_l)
print(conf_matrix)

# Salvar o modelo e o vectorizador
saveRDS(rnd_mdl, "./src/models/random_forest_model.rds")
saveRDS(vectorizer, "./src/models/tfidf_vectorizer.rds")
