class ChaiIo.Views.ReportsIndex extends ChaiIo.Views.Base

	setReportData: (report_data)->
		@report_data = report_data
		@

	reportDataToJSON: -> @report_data.toJSON()

	preRender: ->
	postRender: ->
	
	render: ->
		@setData @report_data.nestDataValues() if @hasNestedDataValues()
		@preRender()
		@reRenderTpl()
		@postRender()
		@
	
	renderTpl: (tplName, container, data)-> 
		return no if tplName is ''
		container.html(ich[tplName] data)
		
	reRenderTpl: -> @renderTpl @getTemplateName(), $(@el), @reportDataToJSON()
	getTemplateName: -> "report_#{@model.getReportType()}"
	
	getReport: -> @model.getReport()

	getColumns: -> @report_data.getColumns()
	getColumnIndex: (colText)-> @report_data.getColumnIndex colText
	columnNameToIndexArray: (fields)-> @report_data.getColumnsIndices fields
	
	getData: -> @report_data.getData()
	setData:(data)-> @report_data.setData data
	
	hasNestedDataValues: -> no

	dateToTime: (dt)-> ChaiIo.Util.dateToTime dt

