class ChaiIo.Views.ReportsIndex extends Backbone.View
	
	preRender: ->
	
	postRender: ->
	
	getFilterDateFormat: -> "yyyy-mm-dd"
	initFilters: -> $('.datepicker').datepicker {"format": @getFilterDateFormat()}
	
	render: ->
		@initFilters()
		@setData @nestDataValues() if @hasNestedDataValues()
		@preRender()
		templateName = @getTemplateName()
		return no if templateName is ''
		$(@el).html(ich[templateName] @getModelJSON())
		@postRender()
		yes
	
	getTemplateName: -> "report_#{@model.get('report_type')}"
	
	getModelJSON: -> @model.toJSON()
	getColumns: -> @model.get 'columns'
	getData: -> @model.get 'data'
	setData:(data)-> @model.set {data: data}
	
	hasNestedDataValues: -> no
	
	nestDataValues: ->
		data = @getData()
		nested = []
		for row in data
			temp = []
			temp.push row[val] for val of row
			nested.push {values: temp}
		nested
	
	dateToTime: (dt)->
		dt = dt.toString()
		dt = dt.split("-")
		month = parseInt(dt[1]) - 1;
		(new Date(dt[0], month, dt[2])).getTime()
	
		