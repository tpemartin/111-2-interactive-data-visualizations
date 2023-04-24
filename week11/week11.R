bigMacData = readRDS("../week10/bigMacData.Rds")
chartB = readRDS("../week10/chartB.Rds")
# helper functions
source("../R/helpers.R")

dataComponent = chartB$allYears$`2000-04-01`$data

getTraceMapping <- function(dataComponent) {
  traceNumbers = seq_along(dataComponent)
  traceNumbers |>
      purrr::map(~{
      dataComponent[[.x]]$name
    }) -> traceNames
  traceNumbers |> as.list() |> setNames(traceNames) -> traceMapping
  traceMapping
}

chartB$allYears$`2000-04-01`$data[[11]]$name


