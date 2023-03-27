library(plotly)
mtcars %>%
  highlight_key(~cyl) -> sharedData

plot_ly(
  data=sharedData,
  x = ~wt, y = ~mpg, text = ~cyl) |>
  add_trace(mode = "markers+text",
    textposition = "top", hoverinfo = "x+y"
  )
plot_ly(
  data=mtcars,
  x = ~wt, y = ~mpg, text = ~cyl) |>
  add_trace(mode = "markers+text",
            textposition = "top", hoverinfo = "x+y"
  )
