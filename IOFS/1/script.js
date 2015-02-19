
document.onreadystatechange = function () {
  var state = document.readyState
    if (state == 'complete') {
        updateText()
  }
}
function updateCharts(){
  firstZipfRule();
  secondZipfRule();
}

function firstZipfRule() {
  var text = document.getElementById("input").value;
  var words = spitByWord(text);

  groups = _.groupBy(words);
  groups = _.sortBy(groups, 'length').reverse()
  
  groups = _.uniq(groups, false, function(gr){ 
    return gr.length
  }); 

  x = _.range(groups.length);
  y = groups.map(function(gr){ return (gr.length / words.length) })
  drawChart(x, y, 'firstZipfChart')
}

function secondZipfRule(){
  var text = document.getElementById("input").value;
  var words = spitByWord(text);

  groups = _.groupBy(words);
  groups = _.sortBy(groups, 'length')

  var length_hahs = new Object();
  
  _.each(groups, function(gr){
    var includeFrequency = gr.length.toString()+"/"+words.length.toString()
    length_hahs[includeFrequency] = length_hahs[includeFrequency]? gr.length + length_hahs[includeFrequency] : gr.length
  })

  x = _.map(length_hahs, function(key,value){return value})
  y = _.map(length_hahs, function(key,value){return key})

  drawChart(x, y, 'secondZipfChart')
}


drawChart = function(x, y, DOMname){
  var name = DOMname + "chartJSObject";
  var data = dataForChart(x, y)

  if(window[name]){
    window[name].destroy()  
  }
  var ctx = document.getElementById(DOMname).getContext("2d");
  window[name] = new Chart(ctx).Line(data);
}

spitByWord = function(text){
  var words = text.replace(/[,\(\)\._\-\-\#$]"/g,' ')
                  .split(' ')

  words = _.reject(words, function(x){ return x.length == 0})
           .map(function(x){
    return x.trim().toLowerCase();    
  });
  return words;
}

dataForChart = function(x, y){
  return  {
            labels: x,
            datasets: [
                {
                    label: "My Second dataset",
                    fillColor: "rgba(151,187,205,0.2)",
                    strokeColor: "rgba(151,187,205,1)",
                    pointColor: "rgba(151,187,205,1)",
                    pointStrokeColor: "#fff",
                    pointHighlightFill: "#fff",
                    pointHighlightStroke: "rgba(151,187,205,1)",
                    data: y
                }]
          }
}

updateText = function(){
  document.getElementById("input").value = document.getElementById('text-select').value;
  firstZipfRule();
  secondZipfRule();
}