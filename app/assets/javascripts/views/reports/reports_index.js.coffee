class ChaiIo.Views.ReportsIndex extends ChaiIo.Views.Base
	preRender: ->
	postRender: ->
	
	render: ->
		@setData @nestDataValues() if @hasNestedDataValues()
		@preRender()
		@reRenderTpl()
		@postRender()
		yes
	
	renderTpl: (tplName, container, data)-> 
		return no if tplName is ''
		container.html(ich[tplName] data)
		
	reRenderTpl: -> @renderTpl @getTemplateName(), $(@el), @getModelJSON()
	
	getTemplateName: -> "report_#{@model.get('report_type')}"
	
	getColumns: -> @model.get 'columns'
	getColumnIndex: (colText)-> 
		colText = colText.trim()
		cols = @getColumns()
		for i of cols
			return i if cols[i] is colText
		no

	columnNameToIndexArray: (fields)->
		mapped = []
		for column_name in fields
			index = @getColumnIndex column_name
			mapped.push index if index
		mapped

	
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
		dt = dt.toString().split "-"
		month = parseInt(dt[1]) - 1;
		(new Date(dt[0], month, dt[2])).getTime()

	getReport: -> @model.get 'report'
	getReportConfig: -> 
		report = @getReport()
		return {} unless report
		report.config

	getReportConfigField: (field)-> @getReportConfig()[field]

	sum: (arr)-> _.reduce arr, ((memo, num)=> return memo + parseInt(num)), 0
	avg: (arr)-> Math.round(@sum(arr) / arr.length)
