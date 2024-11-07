library(httr)
library(jsonlite)

buscar_cep <- function(cep) {
  url_base <- "https://brasilapi.com.br"
  endpoint_cep <- "/api/cep/v2/"
  
  url <- paste0(url_base, endpoint_cep, cep)
  
  GET(url) |>
    content(as = "text") |>
    purrr::discard_at("location") |>
    fromJSON() |>
    tibble::as.tibble() |>
    dplyr::first()
}

buscar_ceps <- function(ceps) {
  ceps |>
    purrr::map(buscar_cep) |>
    dplyr::bind_rows()
}

ceps <- c()
buscar_ceps(ceps)
