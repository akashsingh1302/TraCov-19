<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title>State</title>
  <script src="${pageContext.request.contextPath}/resources/jquery.js"></script>
  <script src="${pageContext.request.contextPath}/resources/Chart.bundle.min.js"></script>
  </head>

<body>
<div id="container">
<canvas id = "graph">
</canvas>
</div>

<script>
$(document).ready(function(){
  	  var i = 0;
  	  var Origy = []
  	  var Origx = []
       i = 0;
      <c:forEach items="${Origx}" var="element">
      Origx[i] = ${element};
      i = i+1;
      </c:forEach>
      
      i = 0;
      <c:forEach items="${Origy}" var="element">
      Origy[i] = ${element};
      i = i+1;
      </c:forEach>
    
      
      labels = []
      for(i=0;i<Origx.length;i++)
    	  {
    	  labels[i] = i+1;
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
	  pointHoverRadius: 3
	        }
        ]
    },
    options: {
    	title: {
            display: true,
            text: 'Maharashtra Curve'
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
})

</script>
</body>
</html>
