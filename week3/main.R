library(readr)

# saving container
bigMac2 = list()
big_mac_raw_index <- read_csv("https://raw.githubusercontent.com/TheEconomist/big-mac-data/master/output-data/big-mac-raw-index.csv")

# split by date for later convenience
big_mac_raw_index |>
  split(big_mac_raw_index$date) -> bigMac2$split$byDate

bigMac2$split$byDate$`2022-07-01`

# prototype

# targetDF
targetDF = bigMac2$split$byDate$`2022-07-01`

# check column names
targetDF |> names()

# Ensure country names are ordered correctly
targetDF |>
  dplyr::arrange(USD) |>
  dplyr::pull("name") -> levelsCountryNames
targetDF$name = factor(targetDF$name, levels=levelsCountryNames)

# ggplot
library(ggplot2)
gg0 = econDV2::Plot()

gg0$ggplot <- {
  targetDF |>
    ggplot(
      mapping=aes(x=name, y=USD*100)
    )
}
gg0$geom <- list(
  geom_col(
    fill="#b7c6cf",
    width = 0.2, mapping=aes(text=name))
)

gg0$theme = list(
  theme_classic(),
  theme(
    axis.line = element_blank(),
    axis.title = element_blank(),
    axis.ticks = element_blank(),
    axis.text.x = element_blank(),
    panel.grid.major.y = element_line()
  ))


geom0 = gg0$geom
gg0$geom |>
  append(
    list(
      geom_point()
    )
  ) -> gg0$geom

gg0$geom[[2]] <-
  geom_point(
    mapping=aes(color=(USD>0))
  )
gg0$scales <- list(
  scale_color_manual(
    values = c("#db444b","#3ebcd2")
  )
)

gg0$theme[[3]] <-
  theme(
    legend.position = "none"
  )

gg0$make()

##
# plotly prototype
library(plotly)
plotly::ggplotly(
  gg0$make()) -> prototype
prototype

bigMac2$ggplotly$`2022-07-01` <- prototype
bigMac2$ggplotly$`2022-07-01`
saveRDS(bigMac2, file="bigMac.Rds")

prototype$x$data[[1]]
trace1 = prototype$x$data[[1]]
library(plotly)
tt= append(list(plot_ly()), trace1)
do.call("add_trace", tt)

View(trace1)

##
targetDF$name
trace1$text = targetDF$name
tt= append(list(plot_ly()), trace1)
do.call("add_trace", tt)

plot_ly() |> econIDV::do_add_trace(trace1) -> plot1

saveRDS(plot1, file="plot1.Rds")
#

pt = econIDV::PlotlyTools()

pt$query_trace$Scatter() -> q
q("hover")

geom_line(
  aes(x=1, )
)

