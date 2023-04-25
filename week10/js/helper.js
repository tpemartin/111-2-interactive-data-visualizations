chartBMap = document.getElementById("chartB-tracemap")
var chartBtracemap = JSON.parse(chartBMap.textContent)

chartCMap = document.getElementById("chartC-tracemap")
var chartCtracemap = JSON.parse(chartCMap.textContent)

chartBxJson = document.getElementById("chartB-x")
var chartBdataLayoutConfig = JSON.parse(chartBxJson.textContent)

/* chart B */
originalStyle = {
    "marker.color": "rgba(248,118,109,1)",
    "marker.size": 8,
    "marker.line.color": "rgba(248,118,109,1)",
    "marker.line.width": 0
}
newStyle = {
        "marker.color": "#006ba2",
        "marker.size": 10,
        "marker.line.color": "#006ba2",
        "marker.line.width": 1.8
}

styleChangeInB = {
    "original": originalStyle,
    "new": newStyle,
    "targetTrace": null
}

/* chart C */
styleChangeInC = {
    "original": {
      "line.color": "rgba(204,204,204,0.3)"},
    "new": {
      "line.color": "#006ba2"},
    "targetTrace": null
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
  Plotly.react(chartBelement,
             chartBdataLayoutConfig[date].data,
             chartBdataLayoutConfig[date].layout,
             chartBdataLayoutConfig[date].config)
}

document.addEventListener('DOMContentLoaded', function () {
  // do something here ...
  // chart B's graph DOM object
  chartBelement = document.getElementById("widget-chartB")
  // chart B's dropdown menu DOM object
  chartBSelect = document.getElementById("plotly-select")
  // chart B's dropdown on change, then do chartBredraw
  chartBSelect.onchange=function(){
    chartBredraw(chartBSelect.value)
  }
}, false);