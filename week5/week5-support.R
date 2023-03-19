extract_countryName = function(x){
  x |>  stringr::str_extract("(?<=(name: ))[^<]+")
}
