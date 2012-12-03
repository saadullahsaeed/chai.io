class ChaiIo.Views.ReportsLine_chart extends ChaiIo.Views.ReportsBar_chart
	
	preRender: ->
		
	postRender: ->
		data = @prepareData()
		console.log data
		nv.addGraph ()=>
			chart = nv.models.lineChart()
			chart.color d3.scale.category10().range()
			chart.x (d, i)=> d.x
			chart.xAxis.tickFormat (d)=> d3.time.format('%x')(new Date(d))
			chart.yAxis.tickFormat d3.format(',.1f')
			d3.select('#line_chart svg').datum(data).transition().duration(1000).call(chart)
			nv.utils.windowResize(chart.update)
			chart
	
	getTemplateName: -> "report_line_chart"
	convertDateToTime: -> yes