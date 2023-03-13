library(readr)

big_mac_raw_index <- read_csv("https://raw.githubusercontent.com/TheEconomist/big-mac-data/master/output-data/big-mac-raw-index.csv")
bigMac = readRDS("bigMac.Rds")

# read ggplotly prototype

gploty0 = bigMac$ggplotly$`2022-07-01`
gploty0$x$data |> length()
gploty0
traces = gploty0$x$data
# trace 1

## plotly trace1
library(plotly)
plot_ly() |>
  econIDV::do_add_trace(
    traces[[1]]
  )

trace1 = traces[[1]]
## change text
trace1$text |>
  stringr::str_extract(
    "(?<=(^name:\\s))[^<]+"
  ) -> trace1$text

plot_ly() |>
  econIDV::do_add_trace(
    trace1
  ) -> p1
p1

# trace 2
trace2 = traces[[2]]
trace2$text = trace2$text |>
  stringr::str_extract(
    "(?<=(^name:\\s))[^<]+"
  ) -> trace2$text
p1 |>
  econIDV::do_add_trace(
    trace2
  ) -> p2
p2

# trace 3
trace3 = traces[[3]]
trace3$text = trace3$text |>
  stringr::str_extract(
    "(?<=(^name:\\s))[^<]+"
  ) -> trace3$text
trace3$showlegend <- FALSE

p2 |>
  econIDV::do_add_trace(
    trace3
  ) -> p3
p3

p3 |>
  layout(
    hovermode="x unified"
  )

# Hover
pt = econIDV::PlotlyTools()
pt$query_trace$Scatter() -> qq
qq("hover")
pt$query_layout$`Color,modebar,hover,and others`() -> qq2
qq2("hover")

#
p3 |>
  plotly::plotly_build() -> p3_build

# Pure plotly: not from ggplotly
bigMac$split$byDate$`2022-07-01` -> targetDF

library(dplyr)
targetDF |>
  arrange(USD) |>
  pull("name") -> levelsName

targetDF$name = factor(targetDF$name,
                       levels= levelsName)
targetDF = targetDF |>
  arrange(USD)

targetDF |> highlight_key(~name) -> targetDF_highlight

plot_ly(
  data = targetDF_highlight
) |>
  add_trace(
    x= ~name,
    y= ~USD
  ) |>
  highlight(on="plotly_hover")

# Find out the type
plot_ly(
  data = targetDF_highlight,
  x=~name,
  y=~USD
) |>
  add_trace(
    type = trace1$type,
    marker = trace1$marker,
    hovertext = ~name,
    hoverinfo = "text"
  ) |>
  add_trace(
    type=trace2$type,
    marker=trace2$marker,
    hoverinfo = "none"
  ) |>
  add_trace(
    type=trace3$type,
    marker=trace3$maker,
    hoverinfo = "none"
  ) |>
  highlight(on="plotly_hover")

##



trace1 |> names() |>
  setdiff(c("x","y")) -> setting1
trace2 |> names() #|>
  setdiff(c("x","y","text")) -> setting2
trace2$type
trace2$mode
trace2$marker
trace1setting = trace1[setting1]

## Create highlighted data with common key
targetDF |> highlight_key(~name) -> targetDF_highlight
targetDF |> split(targetDF$USD >0) -> targetDFSpitByUSD
targetDFSpitByUSD$`FALSE` |>
  highlight_key(~name) -> targetDF_highlight2
targetDFSpitByUSD$`TRUE` |>
  highlight_key(~name) -> targetDF_highlight3

bigMac$ggplotly$`2022-07-01` |> plotly::plotly_build() -> pltBuild

traces = pltBuild$x$data
trace1 = traces[[1]]
trace2 = traces[[2]]
trace3 = traces[[3]]

plot_ly() |>
  econIDV::do_add_trace(trace1) |>
  econIDV::do_add_trace(trace2) |>
  econIDV::do_add_trace(trace3) |>
  layout(showlegend=F)

trace1$x <- NULL
trace1$y <- NULL
trace1$base <- NULL
plot_ly(data=targetDF, x=~name, y=~USD) |>
  econIDV::do_add_trace(
    trace1
  ) -> p1

p1 |> plotly::api_create()

trace2$x <- NULL
trace2$y <- NULL
trace2$text <- NULL
p1 |>
  econIDV::do_add_trace(
    trace2
  )

# Add color
trace2$data = targetDF
trace2$color=~I(USD>0)
p2 |>
  econIDV::do_add_trace(
    trace2
  )

trace2 |> View()

plot_ly(
  x=~name,
  y=~USD
)  |>
  add_trace(
    data = targetDF_highlight,
    type=trace1$type,
    mode=trace1$mode,
    marker=trace1$marker
  ) |>
  add_trace(
    data = targetDF_highlight2,
    type=trace2$type,
    mode=trace2$mode,
    marker=trace2$marker
  ) |>
  add_trace(
    data = targetDF_highlight3,
    type=trace3$type,
    mode=trace3$mode,
    marker=trace3$marker
  ) |>
  highlight(on="plotly_hover", off="plotly_doubleclick")
