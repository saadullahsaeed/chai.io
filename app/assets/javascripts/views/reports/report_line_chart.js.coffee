class ChaiIo.Views.ReportsLine_chart extends ChaiIo.Views.ReportsIndex
	
	hasNestedDataValues: -> yes
	preRender: ->
	
	postRender: ->
		data = @prepareData()
		nv.addGraph ()=>
			chart = nv.models.linePlusBarWithFocusChart()
			chart.margin {top: 30, right: 60, bottom: 50, left: 70}
			chart.x (d, i)=>i
			chart.color d3.scale.category10().range()
			
			xAxisFormatter = (d)=>
				dx = data[0].values[d] && data[0].values[d].x || 0
				return d3.time.format('%x')(new Date(dx)) if dx > 0
				null
				
			chart.xAxis.tickFormat xAxisFormatter
			chart.x2Axis.tickFormat xAxisFormatter
			
			chart.y1Axis.tickFormat d3.format(',f')
			chart.y3Axis.tickFormat d3.format(',f')
			chart.y2Axis.tickFormat (d)=> d3.format(',.2f')(d)
			chart.y4Axis.tickFormat (d)=> d3.format(',.2f')(d)
			
			chart.bars.forceY([0])
			chart.bars2.forceY([0])
		
			d3.select('#line_chart svg').datum(data).transition().duration(500).call(chart)
			nv.utils.windowResize(chart.update)
			chart
	
	prepareData: ->
		data = @getData()
		columns = @getColumns()
		
		colX = columns.shift()
		colBar = columns.shift()
		colLine = columns.shift()
		
		prepared = []
		prepared[0] = []
		prepared[1] = []
		for row in data
			dt = row.values[0]
			if isNaN dt
				dt = dt.split("-")
				dt = (new Date(dt[0], dt[1], dt[2])).getTime()
				
			prepared[0].push {x: dt, y: row.values[1]}
			prepared[1].push {x: dt, y: row.values[2]}
		
		preparedBarData = {bar: true, key: "#{colBar} (left axis)", originalKey: colBar, values: prepared[0]}
		preparedLineData = {key: "#{colBar} (right axis)", originalKey: colLine, values: prepared[1]}
		[preparedBarData, preparedLineData]
	
	getTemplateName: -> "report_line_chart"
	totalColumns: -> @getColumns().length
	
