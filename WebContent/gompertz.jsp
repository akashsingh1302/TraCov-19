<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title>Gompertz</title>
  <script src="${pageContext.request.contextPath}/resources/jquery.js"></script>
  <script src="${pageContext.request.contextPath}/resources/Chart.bundle.min.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/gompertz5.css">
</head>
<body>
<div id="logo2">
  <img src="${pageContext.request.contextPath}/resources/covid1.gif" id="logoimg2"></div> 
  <div id="title">
  predCov
</div>
<div id="topBar">
<div id="gompertz" class="navBtns">Home</div>
<div id="logistic" class="navBtns">Logistic</div>
<div id="bertalanffy" class="navBtns">Bertalanffy</div>
<div id="map" class="navBtns">Map</div>
</div>
<div id="leftBar">
<div class="details" id="day">Day: </div>
<div class="details" id="tday">Day: </div>
<div class="details" id="cases">Day: </div>
<div class="details" id="pcases">Cases: </div>
</div>
<div id="center">
<div id="container">
<canvas id = "graph">
</canvas>
</div>
</div>
<script>
$(document).ready(function(){
  	  var i = 0;
  	  var Orig = []
  	  var Res = []
  	  var Resy = []
  	  var Origy = []
  	  var Origx = []
      
      i = 0;
      <c:forEach items="${Resy}" var="element">
      Resy[i] = ${element};
      i = i+1;
      </c:forEach>      
      i = 0;
      <c:forEach items="${Origy}" var="element">
      Origy[i] = ${element};
      i = i+1;
      </c:forEach>
      labels = []
      for(i=0;i<400;i++)
    	  {
    	  labels[i] = i+1;
    	  }
      console.log(Resy)
      console.log(Origy)
 var ctx = document.getElementById('graph').getContext('2d');
var myChart = new Chart(ctx, {
    type: 'line',
    data: {
	labels:labels,
		datasets: [
			{
	             data: Resy,
	        	 label: 'Predicted Cases',
	  borderColor: 'rgba(200, 0, 0, 0.5)',
	  fill: false, 	
	  type: 'line',
	  pointRadius: 0.1,
	  pointHoverRadius: 3
	        },
	        {
	             data: Origy,
	        	 label: 'Real Cases',
	  borderColor: 'rgba(0, 0, 200, 1)',
	  fill: false, 	
	  type: 'line',
	  pointRadius: 0.1,
	  pointHoverRadius: 3
	        }
        ]
    },
    options: {
    	title: {
            display: true,
            text: 'Gompertz Curve'
          },
    	responsive: true,
    	tooltips:{
    		mode: 'point',
    	},
        scales: {
            yAxes: [{
            	scaleLabel: {
            		display: true,
            		labelString: "Cases"
            	},
                ticks: {
                    beginAtZero: true
                }
            }],
            xAxes:[{
            	scaleLabel: {
            		display: true,
            		labelString: "Day"
            	}
               
            }]
        }
    }
});


$("#day").text("Day: "+labels[(Origy.length) - 1]);
$("#tday").text("Prediction: "+Resy[(Origy.length)-1])
$("#cases").text("Actual Cases: "+Origy[(Origy.length)-1]);
$("#pcases").text("Predicted Max: "+Resy[(Resy.length) - 1]);
$("#gompertz").click(function(){
	location.href = "home";
})
 $("#logistic").click(function(){
	location.href = "logistic";
})
 $("#bertalanffy").click(function(){
	location.href = "bertalanffy";
})
 $("#map").click(function(){
	location.href = "target";
})

})

</script>
</body>
</html>
