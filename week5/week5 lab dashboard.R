library(readr)
big_mac <- read_csv("https://raw.githubusercontent.com/TheEconomist/big-mac-data/master/output-data/big-mac-raw-index.csv")

big_mac_highlight <- big_mac |> plotly::highlight_key()

chartA <- DT::datatable(big_mac_highlight)

chartB <- plotly::plot_ly(big_mac_highlight,
                          x=~date, y=~USD) |>
  add_trace(type="scatter", mode="markers")

dashboardInfo = list(
  chartA=chartA,
  chartB=chartB
)

saveRDS(dashboardInfo, file="dashboardInfo.Rds")
