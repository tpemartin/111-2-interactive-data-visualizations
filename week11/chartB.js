function(e){
  chartB = e //a DOM node object to control chart B
  app.chartB.DOMelement = chartB
  chartB.on("plotly_click",function(ev){
    console.log(ev)
    let countryPicked = ev.points[0].x
    // new trace map does not require [0] at the end
    //let countryTrace = chartBtracemap[countryPicked][0]
    let countryTrace = chartBtracemap[countryPicked]
    clickHighlight(chartB, countryTrace-1, app.chartB.styleChange)
    clickHighlight(chartC, chartCtracemap[countryPicked]-1, app.chartC.styleChange)
  })
}
