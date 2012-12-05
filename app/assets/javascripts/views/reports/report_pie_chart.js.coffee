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
		prepared = []
		for row in data
                        prepared.push {key: row.values[0], y: row.values[1]} 
		prepared
		
		
	getTemplateName: -> "report_pie_chart"
	hasNestedDataValues: -> yes
