library(readr)
library(ggplot2)

modelo <- function(){
  # Ler os dados do CSV
  df <- read_csv("dados_regressao.csv", show_col_types = FALSE)
  # Ajustar o modelo
  modelo <- lm(y ~ x + grupo, df)
  return(modelo)
}

plot <- function(){
  # Ler os dados
  df <- read_csv("dados_regressao.csv", show_col_types = FALSE)

  # Criar o gráfico com ggplot2
  grafico <- ggplot(df, aes(x = x, y = y, color = grupo)) +
    geom_point() +  # Plota os pontos dos dados
    geom_smooth(method = "lm", se = FALSE) +  # Adiciona a reta de regressão
    labs(title = "Regressão Linear: y ~ x + grupo",
         x = "x (Covariável)",
         y = "y (Resposta)") +
    theme_minimal()

  # Exibir o gráfico
  return(print(grafico))
}

plot_Res <- function(){
  # Ler modelo e resíduos
  modelo <- modelo()
  residuos <- resid(modelo)
  # Criar os valores preditos
  valores_preditos <- predict(modelo)

  # Criar um data frame para o gráfico
  dados_residuos <- data.frame(valores_preditos = valores_preditos, residuos = residuos)

  # Criar o gráfico de resíduos
  grafico_residuos <- ggplot(dados_residuos, aes(x = valores_preditos, y = residuos)) +
    geom_point() +  # Pontos dos resíduos
    geom_hline(yintercept = 0, linetype = "dashed") +  # Linha horizontal em y = 0
    labs(title = "Gráfico de Resíduos",
         x = "Valores Preditos",
         y = "Resíduos") +
    theme_minimal()

  # Exibir o gráfico
  print(grafico_residuos)
}
