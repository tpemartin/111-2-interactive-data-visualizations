function(e){
  chartC = e //a DOM node object to control chart
  chartC.on("plotly_click",function(ev){
    console.log(ev)
    let country_name = ev.points[0].data.name
    let countryTrace = chartCtracemap[country_name][0]
    styleChangeInC = clickHighlight(chartC, countryTrace-1, styleChangeInC)
    styleChangeInB = clickHighlight(chartB, chartBtracemap[country_name][0]-1, styleChangeInB)
    })
}
