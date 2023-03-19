bigMac = readRDS("bigMac.Rds")

# read ggplotly prototype

gploty0 = bigMac$ggplotly$`2022-07-01`
gploty0
gploty0 |> plotly::plotly_build() -> pltBuild

gploty0
traces = gploty0$x$data
#
library(plotly)

plot_ly() |>
  econIDV::do_add_trace(traces[[1]]) |>
  econIDV::do_add_trace(traces[[2]]) |>
  econIDV::do_add_trace(traces[[3]]) |>
  layout(
    showlegend=F
  )



p3 |>
  layout(
    hovermode="x unified"
  )

## specify highlight key
targetDF$name |> head()
targetDF |>
  plotly::highlight_key(~name) -> targetDF_highlighted
class(targetDF_highlighted)


plot_ly(
  data = targetDF,
  x = ~name, y= ~USD
) |>
  add_trace()

plot_ly() |>
  econIDV::do_add_trace(
    trace1
  )

plot_ly() |>
  add_trace(
    orientation=trace1$orientation,
    width=trace1$width,
    base=trace1$base,
    x=trace1$x,
    y=trace1$y,
    text=trace1$text,
    type=trace1$type,
    textposition=trace1$textposition,
    marker=trace1$marker,
    showlegend=trace1$showlegend,
    xaxis=trace1$xaxis,
    yaxis=trace1$yaxis,
    hoverinfo=trace1$hoverinfo,
    name=trace1$name
  )

# remove trace1$x, y, base

plot_ly(data = targetDF_highlighted,
            x=~name, y=~USD) |>
  add_trace(
    orientation=trace1$orientation,
    width=trace1$width,
    text=trace1$text,
    type=trace1$type,
    textposition=trace1$textposition,
    marker=trace1$marker,
    showlegend=trace1$showlegend,
    xaxis=trace1$xaxis,
    yaxis=trace1$yaxis,
    hoverinfo=trace1$hoverinfo,
    name=trace1$name
  ) -> p1
p1 |>
add_trace(
    #x=trace2$x,
    #y=trace2$y,
    #text=trace2$text,
    type=trace2$type,
    mode=trace2$mode,
    marker=trace2$marker,
    hoveron=trace2$hoveron,
    name=trace2$name,
    legendgroup=trace2$legendgroup,
    showlegend=trace2$showlegend,
    xaxis=trace2$xaxis,
    yaxis=trace2$yaxis,
    hoverinfo=trace2$hoverinfo
  )

trace2 |> names() -> n2
n2 |>
  paste0("=trace2$", n2,",") |>
  clipr::write_clip()

plot_ly(
  data = targetDF_highlighted,
  x=~name, y=~USD
) |>
  add_trace()

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
library(plotly)
mtcars %>%
  highlight_key(~cyl) %>%
  plot_ly(
    x = ~wt, y = ~mpg, text = ~cyl, mode = "markers+text",
    textposition = "top", hoverinfo = "x+y"
  ) %>%
  highlight(on = "plotly_hover", off = "plotly_doubleclick")


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
