buscar_rodada <- function(rodada) {
  url <- glue::glue(
    "https://api.globoesporte.globo.com/tabela/d1a37fa4-e948-43a6-ba53-ab24ab3a45b1/fase/fase-unica-campeonato-brasileiro-2024/rodada/{rodada}/jogos/"
  )
  
  
  url |>
    httr::GET()  |>
    httr::content(as = "text") |>
    jsonlite::fromJSON() |>
    tibble::as_tibble() |>
    dplyr::select(
      id,
      data_realizacao,
      hora_realizacao, 
      equipes,
      placar_oficial_visitante, 
      placar_oficial_mandante
    ) |>
    dplyr::mutate(
      rodada = rodada,
      time_mandante = equipes$mandante$nome_popular,
      time_visitante = equipes$visitante$nome_popular,
    ) |>
    dplyr::select(
      id,
      rodada,
      data_realizacao,
      hora_realizacao, 
      time_mandante,
      gols_mandante = placar_oficial_visitante, 
      time_visitante,
      gols_visitante = placar_oficial_mandante
    )
}

buscar_rodadas <- function(rodadas) {
  rodadas |>
    purrr::map(buscar_rodada) |>
    dplyr::bind_rows()
}

resultado <- buscar_rodadas(1:5)

res