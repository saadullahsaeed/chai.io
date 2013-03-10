class ChaiIo.Views.ReportsBar_chart extends ChaiIo.Views.ReportsIndex
	
	preRender: ->
	
	postRender: ->
		data = @prepareData()
		nv.addGraph ()=>
			chart = nv.models.multiBarChart()
			chart.xAxis.tickFormat(d3.time.format, '%a')
			chart.yAxis.tickFormat(d3.format ',.1f')
			d3.select('#bar_chart svg').datum(data).transition().duration(500).call(chart)
			nv.utils.windowResize(chart.update)
			chart
	
	prepareData: ->
		data = @getData()
		colX = @getColX()
		
		if @report_data.totalColumns() > 2
			colsY = @report_data.getColumns()
			colsY.shift()
		else
			colsY = [@getColY()]
		
		streams = []
		for y in colsY
			prepared = []
			for value in data
				dt = value[colX]
				dt = @dateToTime(value[colX]) if @convertDateToTime()
				prepared.push {x: dt, y: value[y], series: 0} 
			streams.push {key: y, values: prepared}
		streams
	
	
	getTemplateName: -> "report_bar_chart"
	
	getColX: -> @report_data.getColumns()[0]
	getColY: -> @report_data.getColumns()[1]

	convertDateToTime: -> no
