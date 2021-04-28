<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title>predCov</title>
  <script src="${pageContext.request.contextPath}/resources/jquery.js"></script>
  <script src="${pageContext.request.contextPath}/resources/Chart.bundle.min.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/load2.css">
</head>
<body>
<div id="loadscreen">
  <div id="logo">
  <img src="${pageContext.request.contextPath}/resources/covid1.gif" id="logoimg"></div>
  <div id="loading">
   Initializing...
  </div>
</div>
<div id="logo2">
  <img src="${pageContext.request.contextPath}/resources/covid1.gif" id="logoimg2"></div> 
  <div id="title">
  predCov
</div>
<div id="topBar">
<div id="gompertz" class="navBtns">Gompertz</div>
<div id="logistic" class="navBtns">Logistic</div>
<div id="bertalanffy" class="navBtns">Bertalanffy</div>
<div id="map" class="navBtns">Map</div>
</div>
<div id="leftBar">
<div class="details" id="day">Day: </div>
<div class="details" id="cases">Cases: </div>
</div>
<div id="center">
<div id="container">
<canvas id = "graph">
</canvas>
</div>
</div>
  <script>
  $(document).ready(function(){
		$("#topBar").hide();
		$("#logo2").hide();
		$("#title").hide();
		$("#center").hide();
		$("#leftBar").hide();
	setTimeout(function(){
	 $("#loadscreen").hide()
	 $("#topBar").slideDown()
	 $("#leftBar").slideDown()
	 $("#logo2").slideDown()
	 $("#title").slideDown()
	 $("#center").slideDown()
	},6000);
	var x = ["Initializing..","Plotting Graphs..","Welcome to predCov.."];
	var c = 0;
	setInterval(function(){
		c++;
		c = c%3;
	document.getElementById("loading").innerHTML = x[c];
	},2000);
	
	var Origy = []
	  var Origx = []
    
    i = 0;
    <c:forEach items="${Origx}" var="element">
    Origx[i] = ${element};
    i = i+1;
    </c:forEach>
    console.log(Origx)
    i = 0;
    <c:forEach items="${Origy}" var="element">
    Origy[i] = ${element};
    i = i+1;
    </c:forEach>
    labels = []
    for(i=0;i<Origx.length;i++)
  	  {
  	  labels[i] = Origx[i];
  	  }

    var ctx = document.getElementById('graph').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'line',
        data: {
    	labels:labels,
    		datasets: [
    	        {
    	             data: Origy,
    	        	 label: 'Real Cases',
    	  borderColor: 'rgba(0, 0, 200, 1)',
    	  fill: false, 	
    	  type: 'line',
    	  pointRadius: 0.1,
    	  pointHoverRadius: 5
    	        }
            ]
        },
        options: {
        	title: {
                display: true,
                text: 'India COVID-19 Curve'
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


    
    $("#day").text("Day: "+Origx[(Origx.length) - 1]);
    $("#cases").text("Cases: "+Origy[(Origy.length)-1]);
    $("#gompertz").click(function(){
    	location.href = "gompertz";
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
	     
	});


  </script>
</body>
</html>
