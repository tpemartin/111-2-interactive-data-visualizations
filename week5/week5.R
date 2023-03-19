bigMac = readRDS("bigMac.Rds")
source("week5/week5-support.R")
# take out traces
gploty0 = bigMac$ggplotly$`2022-07-01`
gploty0 |>
  plotly::plotly_build() -> pltBuild0
traces = pltBuild0$x$data
bigMac$build$`2022-07-01` = pltBuild0
# check traces graph
plotly::plot_ly() |>
  econIDV::do_add_trace(
    traces[[1]]
  ) |>
  econIDV::do_add_trace(
    traces[[2]]
  ) |>
  econIDV::do_add_trace(
    traces[[3]]
  )

# purrr::reduce
list(
  plotly::plot_ly(), traces[[1]], traces[[2]], traces[[3]]
) |>
  purrr::reduce(econIDV::do_add_trace)

# If we use purrr::reduce, then we can
c(
  list(plotly::plot_ly()),
  traces) |>
  purrr::reduce(econIDV::do_add_trace)
# since c(...) concatenates vectors' elements

list(plotly::plot_ly()) |>
  c(traces) |>
  purrr::reduce(econIDV::do_add_trace)

# example
c(list(0), list(1, 2, list(3,4)))
# is the same as
list(0, 1, 2, list(3,4))



# Or use purrr::reduce
list(plotly::plot_ly()) |>
  append(traces) |> View()
  purrr::reduce(
    econIDV::do_add_trace
  )

# prepare for direct plotly

## Inside programming block like function body, any binding
# only create/modify inside execution environment. However
# if your binding start with an environment, the binding will
# always work
1:3 |>
  purrr::walk(~{
    .GlobalEnv$traces[[.x]]$text <-
      .GlobalEnv$traces[[.x]]$text |> extract_countryName()
  })

bigMac$traces$`2022-07-01` <- traces
saveRDS(bigMac, file="bigMac.Rds")

##
bigMac = readRDS("bigMac.Rds")

traces =  bigMac$traces$`2022-07-01`
list(plotly::plot_ly()) |>
  c(traces) |>
  purrr::reduce(
   econIDV::do_add_trace
  ) -> p0

# Layout
build = bigMac$build$`2022-07-01`

p0 |>
  plotly::layout(
    showlegend=build$x$layout$showlegend
  )

p0 |>
  econIDV::do_layout(
    build$x$layout
  ) -> p1
p1

# config
build$x$config

p1 |>
  econIDV::do_config(build$x$config)

build$x$config |> names()

pt = econIDV::PlotlyTools()
pt$query_layout$`Color,modebar,hover,and others`() -> qq
qq("modebar")

#
p1 |>
  plotly::api_create() -> link

p1 |>
  plotly::config(showEditInChartStudio = T,
                 plotlyServerURL= link$api_urls$plots)
