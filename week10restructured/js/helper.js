function handleChartBPlotlyClick(ev){
    console.log(ev)
    let countryPicked = ev.points[0].x
    let countryTrace = app.chartB.tracemap[countryPicked][0]
    app.chartB.styleChange = clickHighlight(
        app.chartB.DOM.plotly,
        countryTrace-1, 
        app.chartB.styleChange)
    app.chartC.styleChange = clickHighlight(
        app.chartC.DOM.plotly, 
        app.chartC.tracemap[countryPicked][0]-1, 
        app.chartC.styleChange)
}
function handleChartCPlotlyClick(ev){
  console.log(ev)
  let countryPicked = ev.points[0].data.name
  let countryTrace = app.chartC.tracemap[countryPicked][0]
  app.chartC.styleChange = clickHighlight(
      app.chartC.DOM.plotly,
      countryTrace-1,
      app.chartC.styleChange)
  app.chartB.styleChange = clickHighlight(
      app.chartB.DOM.plotly,
      app.chartB.tracemap[countryPicked][0]-1,
      app.chartB.styleChange)
}
function clickHighlight(chart,trace, styleChange){

    if(styleChange.targetTrace){
        Plotly.restyle(
            chart,
            styleChange.original,
            styleChange.targetTrace
        )
    }

    styleChange.targetTrace=trace

    Plotly.restyle(
        chart,
        styleChange.new,
        styleChange.targetTrace
    )
    return(styleChange)
}

function chartBredraw(date){
  Plotly.react(app.chartB.DOM.plotly,
             app.chartB.dataLayoutConfig[date].data,
             app.chartB.dataLayoutConfig[date].layout,
             app.chartB.dataLayoutConfig[date].config)
}

function handleDropdownMenuChange(ev){
  console.log(ev)
  let date = ev.target.value
  chartBredraw(date)
}
