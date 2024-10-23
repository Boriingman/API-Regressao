API Regressão com plumber
================

# API de Regressão Linear

Esta API foi construída utilizando o pacote `plumber` para realizar
interações com um banco de dados e operações de regressão linear. A API
oferece várias rotas para inserção de dados, inferência estatística, e
predições baseadas nos dados.

## Como rodar a API

1.  Instale o pacote `plumber` se ainda não estiver instalado:

    ``` r
    install.packages('plumber')
    ```

2.  Execute a API em seu ambiente R utilizando o seguinte código:

    ``` r
    library(plumber)
    r <- plumb('Plumber.R')
    r$run(port=8000)
    ```

3.  Acesse a API no navegador ou ferramentas como **Postman** no
    endereço:

        http://localhost:8000

## Rotas Disponíveis

### 1. Inserir novos dados (`/registro`)

**Método:** POST  
**Parâmetros:**  
- `xN`: valor numérico para a covariável `x`. - `yN`: valor numérico
para a variável resposta `y`. - `grupoN`: valor categórico para `grupo`
(A, B ou C).

**Exemplo de requisição:**

``` bash
curl -X POST 'http://localhost:8000/registro?xN=2.5&yN=7.8&grupoN=A'
```

### 2. Retornar as estimativas do modelo (`/est`)

**Método:** GET  
**Retorna:** Os coeficientes estimados do modelo de regressão no formato
JSON.

**Exemplo de requisição:**

``` bash
curl http://localhost:8000/est
```

### 3. Retornar gráfico dos dados e da regressão (`/plot`)

**Método:** GET  
**Retorna:** Um gráfico JPEG mostrando os dados do banco, separados por
grupo, com a reta de regressão ajustada.

**Exemplo de requisição:**

``` bash
curl http://localhost:8000/plot --output grafico.jpeg
```

### 4. Retornar resíduos do modelo (`/res`)

**Método:** GET  
**Retorna:** Os resíduos do modelo de regressão no formato JSON.

**Exemplo de requisição:**

``` bash
curl http://localhost:8000/res
```

### 5. Retornar significância dos coeficientes (`/sig`)

**Método:** GET  
**Retorna:** Os coeficientes do modelo com seus p-valores no formato
JSON.

**Exemplo de requisição:**

``` bash
curl http://localhost:8000/sig
```

### 6. Fazer predições com novos dados (`/multipla_predicao_req`)

**Método:** POST  
**Corpo da requisição:** JSON com as variáveis `x` e `grupo`.

**Exemplo de requisição:**

``` bash
curl -X POST http://localhost:8000/multipla_predicao_req -H 'Content-Type: application/json' -d '{"x":[5.5, 2.8], "grupo":["A", "B"]}'
```

**Retorno:** As predições baseadas no modelo treinado, no formato JSON.

## Conclusão

Esta API oferece ferramentas poderosas para manipulação de dados e
análise de regressão linear. Utilize as rotas descritas para interagir
com os dados e obter insights estatísticos.
