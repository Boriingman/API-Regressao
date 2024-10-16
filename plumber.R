library(plumber)
library(jsonlite)
source("funcao.R")

#* @apiTitle API Regressão

#* Registro no banco de dados
#* @param xN Adiciona x
#* @param yN Adiciona y
#* @param grupoN adiciona grupo
#* @post /registro
function(xN, yN, grupoN){
  dados <- readr::read_csv("dados_regressao.csv", show_col_types = FALSE)
  dados <- rbind(dados,
                   data.frame(
                     x = xN,
                     y = yN,
                     grupo = grupoN,
                     momento_registro = lubridate::now()))
  readr::write_csv(dados, "dados_regressao.csv")
}


#* Retorna estimativa formato JSON
#* @serializer json
#* @get /est
function(){
  # Obter as estimativas dos parâmetros
  coeficientes <- coef(modelo())

  # Retornar as estimativas
  return(coeficientes)
}

#* Retorna gráfico com os dados
#* @serializer jpeg
#* @get /plot
function(){
  plot()
}

#* Retorna resíduo formato JSON
#* @serializer json
#* @get /res
function(){
  # Obter as estimativas dos parâmetros
  residuos <- resid(modelo())

  # Retornar os resíduos
  return(residuos)
}

#* Retorna gráfico com os dados
#* @serializer jpeg
#* @get /plotRes
function(){
  plot_Res()
}

#* Retorna significância dos parâmetros do modelo
#* @serializer json
#* @get /sig
function(){
  # Obter o resumo do modelo
  resumo_modelo <- summary(modelo())
  # Extrair os coeficientes e p-valores
  tabela_significancia <- resumo_modelo$coefficients
  coeficientes <- tabela_significancia[, "Estimate"]
  p_valores <- tabela_significancia[, "Pr(>|t|)"]

  # Criar uma lista com os resultados
  resultado_significancia <- list(
    coeficientes = coeficientes,
    p_valores = p_valores
  )

  # Retornar os resultados em formato JSON
  return(resultado_significancia)
}

#* Predição com Múltiplos Valores
#* @param valores requisição dos valores
#* @post /multipla_predicao
#* @serializer unboxedJSON
function(valores) {
  # Ler os dados enviados no corpo da requisição
  novo_dados <- fromJSON(valores)

  # Verificar se os dados fornecidos têm as colunas corretas
  if (!all(c("x", "grupo") %in% names(novo_dados))) {
    return(list(error = "Dados fornecidos devem conter as colunas 'x' e 'grupo'."))
  }

  # Transformar os dados recebidos em um data frame
  df_novo_dados <- data.frame(
    x = novo_dados$x,
    grupo = as.factor(novo_dados$grupo)  # Certificar-se de que 'grupo' é um fator
  )

  # Realizar as predições com base nos novos dados
  predicoes <- predict(modelo(), newdata = df_novo_dados)

  # Retornar as predições como JSON
  return(list(predicoes = predicoes))
}

#* @param teste requisição dos valores
#* @post /multipla_predicaoteste
function(teste) {
  novo_dados <- fromJSON(teste)
  print(novo_dados)
}



