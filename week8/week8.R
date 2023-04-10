big_mac_raw_index <- readr::read_csv("https://raw.githubusercontent.com/TheEconomist/big-mac-data/master/output-data/big-mac-raw-index.csv")
bigMac2 = readRDS("../week7/bigMac2.Rds")
bigMac = readRDS("../bigMac.Rds")
dplyr::glimpse(big_mac_raw_index)
chartC <- new.env()
library(ggplot2)
library(plotly)
library(econIDV)
bigMacData = new.env()
# data ---------
## reorder factor full sample one year--------
{
  dd = {
    bigMac$split$byDate$`2022-07-01` |>
      mutate(
        name = forcats::fct_reorder(name, USD)
      )
  }
  bigMacData$oneYear = dd
}
##
{
  bigMac2$data  -> bigMacData$allYearsWithNA
}
# ## shared data
# ### full sample
# {
#   dd |>
#     plotly::highlight_key(~name, group="bigMac") -> bigMacData$shared$full
# }
## two subsamples -------
{

  bigMacData$oneYearUSDPos <-
    bigMacData$oneYear |>
    dplyr::filter(
      USD>0
    )
  bigMacData$allYearsWithNA |>
    dplyr::filter(
      USD>0
    ) -> bigMacData$allYearsWithNAUSDPos
  bigMacData$oneYearUSDneg <-
    bigMacData$oneYear |>
    dplyr::filter(
      USD <=0
    )
  bigMacData$allYearsWithNA |>
    dplyr::filter(
      USD<=0
    ) -> bigMacData$allYearsWithNAUSDNeg
}
# trace 4: vanilla ----
{
  traces = bigMac2$traces
  length(traces)
  plot_ly() |>
    do_add_trace(traces[[1]]) |>
    do_add_trace(traces[[2]]) |>
    do_add_trace(traces[[4]]) |>
    hide_legend() |>
    config(displayModeBar=F) -> p0
  chartC$complete = list(
    trace4original = p0
  )
  chartC$complete$trace4original
}

# Chart C ------
## regular data -------
{
  plot_ly() |>
    add_trace(
      data=bigMacData$allYearsWithNAUSDNeg,
      x = ~date,
      y = ~USD,
      # x = traces[[1]]$x,
      # y = traces[[1]]$y,
      # text = traces[[1]]$text,
      type = traces[[1]]$type,
      mode = traces[[1]]$mode,
      marker = traces[[1]]$marker,
      hoveron = traces[[1]]$hoveron,
      name = traces[[1]]$name,
      legendgroup = traces[[1]]$legendgroup,
      showlegend = traces[[1]]$showlegend,
      xaxis = traces[[1]]$xaxis,
      yaxis = traces[[1]]$yaxis,
      hoverinfo = traces[[1]]$hoverinfo,
      frame = traces[[1]]$frame
    ) |> #plotly_build() |> View()
    add_trace(
      data = bigMacData$allYearsWithNAUSDPos,
      x = ~date,
      y = ~USD,
      # x = traces[[2]]$x,
      # y = traces[[2]]$y,
      # text = traces[[2]]$text,
      type = traces[[2]]$type,
      mode = traces[[2]]$mode,
      marker = traces[[2]]$marker,
      hoveron = traces[[2]]$hoveron,
      name = traces[[2]]$name,
      legendgroup = traces[[2]]$legendgroup,
      showlegend = traces[[2]]$showlegend,
      xaxis = traces[[2]]$xaxis,
      yaxis = traces[[2]]$yaxis,
      hoverinfo = traces[[2]]$hoverinfo,
      frame = traces[[2]]$frame
    ) |>
    add_trace(
      data = bigMacData$allYearsWithNA,
      x = ~date,
      y = ~USD,
      split = ~name,
      text = ~name,
      # x = traces[[4]]$x,
      # y = traces[[4]]$y,
      # text = traces[[4]]$text,
      type = traces[[4]]$type,
      mode = traces[[4]]$mode,
      line = traces[[4]]$line,
      hoveron = traces[[4]]$hoveron,
      showlegend = traces[[4]]$showlegend,
      xaxis = traces[[4]]$xaxis,
      yaxis = traces[[4]]$yaxis,
      hoverinfo = traces[[4]]$hoverinfo,
      frame = traces[[4]]$frame
    )
}
## highlight ----
#### use scatterGL -------
{
  traces[[1]]$marker$opacity <- 0.3
  traces[[2]]$marker$opacity <- 0.3
  plot_ly() |>
    add_trace(
      data=bigMacData$allYearsWithNAUSDNeg,
      x = ~date,
      y = ~USD,
      # x = traces[[1]]$x,
      # y = traces[[1]]$y,
      # text = traces[[1]]$text,
      type = "scattergl", #traces[[1]]$type,
      mode = traces[[1]]$mode,
      marker = traces[[1]]$marker,
      # hoveron = traces[[1]]$hoveron,
      name = traces[[1]]$name,
      legendgroup = traces[[1]]$legendgroup,
      showlegend = traces[[1]]$showlegend,
      xaxis = traces[[1]]$xaxis,
      yaxis = traces[[1]]$yaxis,
      hoverinfo = traces[[1]]$hoverinfo,
      frame = traces[[1]]$frame
    ) |> #plotly_build() |> View()
    add_trace(
      data = bigMacData$allYearsWithNAUSDPos,
      x = ~date,
      y = ~USD,
      # x = traces[[2]]$x,
      # y = traces[[2]]$y,
      # text = traces[[2]]$text,
      type = "scattergl", #traces[[2]]$type,
      mode = traces[[2]]$mode,
      marker = traces[[2]]$marker,
      # hoveron = traces[[2]]$hoveron,
      name = traces[[2]]$name,
      legendgroup = traces[[2]]$legendgroup,
      showlegend = traces[[2]]$showlegend,
      xaxis = traces[[2]]$xaxis,
      yaxis = traces[[2]]$yaxis,
      hoverinfo = traces[[2]]$hoverinfo,
      frame = traces[[2]]$frame
    ) |>
    add_trace(
      data = bigMacData$allYearsWithNA |> plotly::highlight_key(~name, group="bigMac"),
      x = ~date,
      y = ~USD,
      split = ~name,
      text = ~name,
      # x = traces[[4]]$x,
      # y = traces[[4]]$y,
      # text = traces[[4]]$text,
      type = traces[[4]]$type,
      mode = traces[[4]]$mode,
      line = traces[[4]]$line,
      hoveron = traces[[4]]$hoveron,
      showlegend = traces[[4]]$showlegend,
      xaxis = traces[[4]]$xaxis,
      yaxis = traces[[4]]$yaxis,
      hoverinfo = traces[[4]]$hoverinfo,
      frame = traces[[4]]$frame
    )  |>
    layout(
      yaxis=list(
        fixedrange=T, # stop y being zoomable.
        range=list(-1,2) # set fixed range even after each filter re-drawals.
      )
    ) |>
    hide_legend() |>
    config(displayModeBar=F) |>
    highlight(
      on="plotly_hover", color="#006ba2")-> p3

  chartC$complete$trace4highlight$withScatterGL = p3

  chartC$complete$trace4highlight$withScatterGL
}
# Chart B ----
chartB <- new.env()
## ggplot ----
{
  library(ggplot2)
  ggplot(data=dd) +
    geom_segment(
      mapping=aes(
        x=name, xend=name,
        y=0, yend=USD
      )
    ) +
    geom_point(
      mapping=aes(
        x=name, y=USD, color=USD>0
      )
    ) +
    geom_hline(
      yintercept=0,
      linewidth=0.5
    ) +
    theme_classic() +
    theme(
      legend.position = "none",
      axis.line.x = element_blank(),
      axis.title.x = element_blank(),
      axis.ticks.x = element_blank(),
      axis.text.x = element_blank()
    ) -> chartB$ggplot
  chartB$ggplot
}
## build --------
{
  chartB$ggplot |>
    plotly::ggplotly() |> plotly::plotly_build() ->
  chartB$build
}
## traces ----
{
  # bigMac <- readRDS("../bigMac.Rds")
  # bigMac$build$`2022-07-01`$x$data |> length()
  chartB$traces = chartB$build$x$data
}
## do_add_trace check ----
{
  plot_ly() |>
    do_add_trace(
      chartB$traces[[1]]
    ) |>
    do_add_trace(
      chartB$traces[[2]]
    ) |>
    do_add_trace(
      chartB$traces[[3]]
    )
}

## highlight -------
{


  plot_ly() |>
    add_segments(
      data=bigMacData$oneYear,
      x = ~name, xend=~name,
      y = 0, yend= ~USD,
      type="scattergl"
    ) |>
    add_trace(
      data = bigMacData$oneYearUSDneg |> plotly::highlight_key(~name, group="bigMac2"),
      x = ~name,
      y = ~USD,
      text = ~name,
      # x = chartB$traces[[2]]$x,
      # y = chartB$traces[[2]]$y,
      # text = chartB$traces[[2]]$text,
      type = chartB$traces[[2]]$type,
      mode = chartB$traces[[2]]$mode,
      marker = chartB$traces[[2]]$marker,
      hoveron = chartB$traces[[2]]$hoveron,
      name = chartB$traces[[2]]$name,
      legendgroup = chartB$traces[[2]]$legendgroup,
      showlegend = chartB$traces[[2]]$showlegend,
      xaxis = chartB$traces[[2]]$xaxis,
      yaxis = chartB$traces[[2]]$yaxis,
      hoverinfo = chartB$traces[[2]]$hoverinfo
    ) |>
    add_trace(
      data = bigMacData$oneYearUSDPos |> plotly::highlight_key(~name, group="bigMac2"),
      x = ~name,
      y = ~USD,
      text = ~name,
      # x = chartB$traces[[3]]$x,
      # y = chartB$traces[[3]]$y,
      # text = chartB$traces[[3]]$text,
      type = chartB$traces[[3]]$type,
      mode = chartB$traces[[3]]$mode,
      marker = chartB$traces[[3]]$marker,
      hoveron = chartB$traces[[3]]$hoveron,
      name = chartB$traces[[3]]$name,
      legendgroup = chartB$traces[[3]]$legendgroup,
      showlegend = chartB$traces[[3]]$showlegend,
      xaxis = chartB$traces[[3]]$xaxis,
      yaxis = chartB$traces[[3]]$yaxis,
      hoverinfo = chartB$traces[[3]]$hoverinfo
    )  |>
    layout(
      yaxis=list(
        fixedrange=T, # stop y being zoomable.
        range=list(-0.7,0.5) # set fixed range even after each filter re-drawals.
      )
    ) |>
    hide_legend() |>
    config(displayModeBar=F) |>
    highlight(
      on="plotly_hover", color="#006ba2") -> chartB$highlight

  chartB$highlight
}

saveRDS(chartC, file="chartC.Rds")
saveRDS(chartB, file="chartB.Rds")
saveRDS(bigMacData, file="bigMacData.Rds")
