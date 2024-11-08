library(xml2)

# URL + parâmetros

base_url <- "https://ptax.bcb.gov.br"

url <- glue::glue("{base_url}/ptax_internet/consultaBoletim.do?method=consultarBoletim")

params <- list(
  RadOpcao = 1,
  DATAINI = "08/10/2024",
  DATAFIM = "07/11/2024",
  ChkMoeda = 61
)

# Requisição
res <- httr::POST(
  url,
  body = params,
  encode = "form"
)

# Resposta
html <- xml2::read_html(res)

file_path <- html |>
  xml2::xml_find_first("//a") |>
  xml2::xml_attr("href") 

read.csv(
  text=glue::glue("{base_url}{file_path}") |>
    httr::GET() |>
    httr::content(as="text"),
  sep = ";", dec = ",", header = FALSE)
