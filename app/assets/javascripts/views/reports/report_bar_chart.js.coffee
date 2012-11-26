class ChaiIo.Views.ReportsBar_chart extends ChaiIo.Views.ReportsIndex
	
	preRender: ->
		@margin = {top: 20, right: 20, bottom: 30, left: 40}
		@width = 960 - @margin.left - @margin.right
		@height = 500 - @margin.top - @margin.bottom

		@x = d3.scale.ordinal().rangeRoundBands([0, @width], 0.1)
		@y = d3.scale.linear().range([@height, 0])
		
		@xAxis = d3.svg.axis().scale(@x).orient("bottom")
		@yAxis = d3.svg.axis().scale(@y).orient("left").tickFormat(d3.format "d")
		
		
	postRender: ->
		outer = @
		data = @getDataForChart()
		columns = @model.get('columns')
		colX = columns[0]
		colY = columns[1]
			
		@x.domain(_.pluck data, colX)
		@y.domain([0, _.max(_.pluck data, colY)])
		
		@svg = d3.select(@el).append("svg").attr("width", @width + @margin.left + @margin.right).attr("height", @height + @margin.top + @margin.bottom).append("g").attr("transform", "translate(#{@margin.left}, #{@margin.top})")
		
		@svg.append("g").attr("class", "x axis").attr("transform", "translate(0, #{@height})").call(@xAxis)
		@svg.append("g").attr("class", "y axis").call(@yAxis).append("text").attr("transform", "rotate(-90)").attr("y", 6).attr("dy", ".71em").style("text-anchor", "end").text(colY)
		
		@svg.selectAll(".bar").data(data).enter().append("rect").attr("class", "bar").attr("x", (d)=>outer.x(d[colX])).attr("width", @x.rangeBand()).attr("y", (d)=>outer.y(d[colY])).attr("height", (d)=>outer.height - outer.y(d[colY]))
		
		@svg.selectAll("text").data(data).enter().append("text").attr("class", "text").attr("x", @x).attr("y", (d)=>outer.y(d[colY]) + outer.y.rangeBand()/2).attr("dx", -5).attr("dy", "1em").attr("text-anchor", "end").text(String)
		
	getDataForChart: -> @model.get('data')
		
	getTemplateName: -> "report_bar_chart"
	
	
	
