class ChaiIo.Views.ReportsPie_chart extends ChaiIo.Views.ReportsIndex
	
	preRender: ->
		@width = 900
		@height = 600
	
	postRender: ->
		data = @prepareData()
		nv.addGraph ()=>
			chart = nv.models.pieChart()
			chart.x (d)=> d.key
			chart.y (d)=> d.y
			chart.values (d)=> d
			chart.color d3.scale.category10().range()
			chart.width @width
			chart.height @height
			
			d3.select('#svg_pie_chart').datum([data]).transition().duration(1200).attr('width', @width).attr('height', @height).call(chart)
			chart
	
	prepareData: ->
		data = @getData()
		data = data.shift()
		columns = @getColumns()

		prepared = []
		for col, i in columns
			prepared.push {key: col, y: data.values[i]} unless _.isUndefined(data.values[i]) || isNaN(data.values[i])
		prepared
		
		
	getTemplateName: -> "report_pie_chart"
	hasNestedDataValues: -> yes
