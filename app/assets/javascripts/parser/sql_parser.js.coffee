class window.SQLParser 
	constructor: (query)->
		@query = query
		
	parse: ->
		@fields = @parseFields()
	
	getFields: -> @fields
	parseFields: ->
		matches = @query.match /select (.*)? from/i
		return unless matches
		matches = matches[1]
		fields = matches.split ','
		@fields = []
		for i of fields
			continue unless fields[i]
			field_name = fields[i].trim()
			field_name = field_name.split(' ').pop() if field_name.match(" ")
			@fields.push field_name
		@fields
			
		
		
		
		
	