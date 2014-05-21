class ChaiIo.Views.ReportsScatter_chart extends ChaiIo.Views.ReportsIndex
	
	preRender: ->
	
	postRender: ->
		data = @prepareData()
		colX = @getColX()
		colY = @getColY()

		nv.addGraph ()=>
			chart = nv.models.scatterChart()
			chart.color(d3.scale.category10().range())
			chart.xAxis.tickFormat(d3.format ',').axisLabel(colX)
			chart.yAxis.tickFormat(d3.format ',').axisLabel(colY)
			chart.tooltipContent((key, x, y, e) -> e.point.size)
			chart.showControls(false)
			d3.fisheye = false # strange fix for fisheye causing issues with selecting legend elements
			d3.select('#scatter_chart svg').datum(data).transition().duration(350).call(chart)
			nv.utils.windowResize(chart.update)
			chart

	prepareData: ->

		data = @getData()

		colX = @getColX()
		colY = @getColY()
		colSize = @getColSize()
		colLabel = @getColLabel()

		# small list to keep track of names to indexes while adding
		indexes = []
		streams = []

		for row in data
			groupLabel = row[colLabel]

			if !(groupLabel in indexes)
				indexes.push(groupLabel)
				streams.push({
      	  key: groupLabel,
      	  values: []
   		  })

			groupIndex = indexes.indexOf(groupLabel)

			streams[groupIndex].values.push({
        x: row[colX],
        y: row[colY],
        size: row[colSize]
      })
  streams
	
	
	getTemplateName: -> "report_scatter_chart"
	
	getColX: -> @report_data.getColumns()[0]
	getColY: -> @report_data.getColumns()[1]
	getColSize: -> @report_data.getColumns()[2]
	getColLabel: -> @report_data.getColumns()[3]

	convertDateToTime: -> no
