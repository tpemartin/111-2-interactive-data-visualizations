document.addEventListener('DOMContentLoaded', function () {
    // do something here ...
    let chartBMap = document.getElementById("chartB-tracemap")
    app.chartB.tracemap = JSON.parse(chartBMap.textContent)
    // var chartBtracemap = JSON.parse(chartBMap.textContent)

    let chartCMap = document.getElementById("chartC-tracemap")
    app.chartC.tracemap = JSON.parse(chartCMap.textContent)
    // var chartCtracemap = JSON.parse(chartCMap.textContent)

    let chartBxJson = document.getElementById("chartB-x")
    app.chartB.dataLayoutConfig = JSON.parse(chartBxJson.textContent)
    // var chartBdataLayoutConfig = JSON.parse(chartBxJson.textContent)

    // chart B's graph DOM object
    app.chartB.DOM = {}
    app.chartB.DOM.plotly = document.getElementById("widget-chartB")
    //  chartBelement = document.getElementById("widget-chartB")
    // chart B's dropdown menu DOM object
    app.chartB.DOM.dropdownMenu = document.getElementById("plotly-select")
    // chartBSelect = document.getElementById("plotly-select")
    // chart B's dropdown on change, then do chartBredraw
    app.chartB.DOM.dropdownMenu.onchange = function(){
        chartBredraw(app.chartB.DOM.dropdownMenu.value)
    }
    // chartBSelect.onchange=function(){
    //   chartBredraw(chartBSelect.value)
    // }

    // chart C's graph DOM object
    app.chartC.DOM = {}
    app.chartC.DOM.plotly = document.getElementById("widget-chartC")

    // chart B click highlight
    app.chartB.DOM.plotly.on("plotly_click",function(ev){
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
      })

    // chart C click highlight
    app.chartC.DOM.plotly.on("plotly_click",function(ev){
        console.log(ev)
        let countryPicked = ev.points[0].x
        let countryTrace = app.chartC.tracemap[countryPicked][0]
        app.chartC.styleChange = clickHighlight(
            app.chartC.DOM.plotly,
            countryTrace-1,
            app.chartC.styleChange)
        app.chartB.styleChange = clickHighlight(
            app.chartB.DOM.plotly,
            app.chartB.tracemap[countryPicked][0]-1,
            app.chartB.styleChange)
    })
  }, false);
  