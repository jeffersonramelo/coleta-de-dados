# Define o caminho do arquivo CSV
df <-read.csv('fatos relevantes 2023.csv', sep = ",")
View(df)

# Acessar a célula 1 da coluna "Link_Download"
celula <- df$Link_Download[1]

print(celula)

#Excluir Linhas NA da coluna Link_Download
df <- df[!is.na(df$Link_Download), ]
View(df)




# Instale as bibliotecas necessárias, se ainda não estiverem instaladas
install.packages("pdftools")
install.packages("httr")
install.packages("dplyr")

# Carregue as bibliotecas
library(pdftools)
library(httr)
library(dplyr)

# Função para extrair texto de um arquivo PDF
extrair_texto_pdf <- function(caminho_arquivo) {
  texto <- pdf_text(caminho_arquivo)
  texto <- paste(texto, collapse = " ")
  return(texto)
}

# Aplicar a função de extração de texto para cada link de download
df <- df %>%
  mutate(texto = sapply(Link_Download, function(url) {
    # Baixar o arquivo PDF
    response <- GET(url)
    caminho_arquivo <- tempfile(fileext = ".pdf")
    writeBin(content(response, "raw"), caminho_arquivo)
    
    # Extrair texto do arquivo PDF
    texto_pdf <- extrair_texto_pdf(caminho_arquivo)
    
    return(texto_pdf)
  }))

# visualizando o link da celula 1 (ou qualquer) da coluna texto
primeira_celula <- df$texto[1]

# Exibe o texto da célula escolhida
print(primeira_celula)



# Acessar a célula 1 da coluna "texto"
celula <- df$texto[1]

print(celula)


# Salvar o DataFrame em um arquivo CSV
write.csv(df, file = "C:/Users/jeffe/Desktop/fatorelevante2023texto.csv", row.names = FALSE)









#Limpar o Enviroment (caso precise em algum momento)
rm(list = ls())





