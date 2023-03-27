function(e){
  plt = e;
  temp1 = document.getElementById("mydiv")

  plt.on('plotly_hover', function(e){
      //console.log(e)
      let temp2 = e
      let countryname = temp2.points[0].data.name
      console.log(countryname)

      temp1.innerText = countryname
  })
}


