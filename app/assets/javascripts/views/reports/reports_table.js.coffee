class ChaiIo.Views.ReportsTable extends ChaiIo.Views.ReportsIndex
	constructor: (options)->
		@events = 
			'click .tbl_r_col': 'sortHandler'
			'keyup #search_keywords': 'search'
			'keydown #search_keywords': 'search'
		super options

	search: (event)->
		search_term = @$('#search_keywords').val()
		data = @getData()
		return @showTable data if search_term is ''
		@showTable(@report_data.filterData search_term)	
	
	getTemplateName: -> "report_table"
	hasNestedDataValues: -> yes

	sortHandler: (event)->
		col = $(event.currentTarget).text()
		@setData @report_data.sortModel(@getColumnIndex col)
		@reRenderTpl()
		
	showTable: (data)-> 
		@setSummary data
		model_json = @reportDataToJSON()
		model_json.data = data
		@renderTpl 'tpl_table_body', @$('#tbody'), model_json
	
	preRender: -> 
		@setSummary @getData()

	reportDataToJSON: -> 
		report_data = super
		return report_data unless @model.isReportLinked()
		col_index = @getColumnIndex @model.getLinkedColumn()
		for i of report_data.data
			column_value = report_data.data[i].values[col_index]
			report_data.data[i].values[col_index] = @linkColumn column_value
		report_data

	linkColumn: (value)-> 
		linked_report_id = @model.getLinkedReport()
		linked_filter_name = @model.getLinkedFilter()
		"<a href='/reports/#{linked_report_id}?#{linked_filter_name}=#{encodeURIComponent value}' target='_blank'>#{value}</a>"	

	setSummary: (data)-> @report_data.setSummaryRow(@getSummaryRow data) if @summaryEnabled() 

	summaryEnabled: -> @getFieldsToSum() || @getFieldsToAverage()
	getFieldsToSum: -> @model.getFieldsToSum()
	getFieldsToAverage: -> @model.getFieldsToAverage()

	getSummaryRow: (data)->
		summary = []
		sum_fields = @getFieldsToSum()
		avg_fields = @getFieldsToAverage()
		columns = @getColumns()
		for i of columns
			summary[i] = '' unless summary[i]
			if _.indexOf(sum_fields, columns[i]) >= 0
				summary[i] = @report_data.getColumnSum columns[i]
			else if _.indexOf(avg_fields, columns[i]) >= 0
				summary[i] = @report_data.getColumnAvg columns[i]
		summary
			
