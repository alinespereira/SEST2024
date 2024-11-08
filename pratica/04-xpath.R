html <- xml2::read_html("pratica/html_exemplo.html")

# Coletar todos os nodes com a tag <p>
# com xml_find_all()
all_ps <- xml2::xml_find_all(html, xpath = "/html/body/p")

# Apenas o primeiro com xml_find_first()
first_p <- xml2::xml_find_first(html, xpath = "/html/body/p")


# Extrair o texto contido em cada um dos nodes
# com xml_text()
purrr::map(all_ps, xml2::xml_text)

# Extrai o atributo style contido em cada note
# com xml_attr
purrr::map(all_ps, function(node) xml2::xml_attr(node, "style"))
