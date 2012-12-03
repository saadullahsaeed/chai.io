class ChaiIo.Views.ReportsLine_chart extends ChaiIo.Views.ReportsBar_chart
	
	preRender: ->
	
	postRender: ->
		data = @prepareData()
		console.log data
		nv.addGraph ()=>
			chart = nv.models.lineChart()
			chart.x (d, i)=> i
			chart.xAxis.tickFormat(d3.time.format, '%a')
			chart.yAxis.axisLabel('yAxis Label').tickFormat d3.format(',.2f')
			d3.select('#line_chart svg').datum(data).transition().duration(500).call(chart)
			nv.utils.windowResize(chart.update)
			chart
	
	getTemplateName: -> "report_line_chart"
	
