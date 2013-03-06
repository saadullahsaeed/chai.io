class ChaiIo.Views.ReportsTable extends ChaiIo.Views.ReportsIndex
	constructor: (options)->
		@events = 
			'click .tbl_r_col': 'sortHandler'
			'keyup #search_keywords': 'search'
			'keydown #search_keywords': 'search'
		super options
		
	search: (event)->
		search_term = $('#search_keywords').val()
		data = @getData()
		return @showTable data if search_term is ''
		@showTable(@filterData search_term)	
	
	getTemplateName: -> "report_table"
	hasNestedDataValues: -> yes

	sortHandler: (event)->
		col = $(event.currentTarget).text()
		@setData @sortModel(@getColumnIndex col)
		@reRenderTpl()
		
	sortModel: (colIndex)->
		return if colIndex is no
		_.sortBy @getData(), (obj)=> obj.values[colIndex]
		
	showTable: (data)-> 
		@setSummary data
		model_json = @getModelJSON()
		model_json.data = data
		@renderTpl 'tpl_table_body', $('#tbody'), model_json
	
	filterData: (searchTerm)-> 
		data = @getData()
		filtered = _.filter data, (item)=>
			for val in item.values
				val = "#{val}" if typeof val isnt 'string'
				return yes if val.toLowerCase().indexOf(searchTerm.toLowerCase(0)) >= 0
		filtered

	preRender: -> @setSummary @getData()

	setSummary: (data)->
		has_summary = no
		if @summaryEnabled()
			has_summary = yes
			summary_row = @getSummaryRow data
		@model.set {has_summary: has_summary, summary: summary_row}

	summaryEnabled: -> @getFieldsToSum() || @getFieldsToAverage()

	getFieldsToSum: -> 
		config_sum = @getReportConfigField('sum')
		return config_sum.split ',' if config_sum
		no

	getFieldsToAverage: -> 
		config_avg = @getReportConfigField('average')
		return config_avg.split ',' if config_avg
		no

	getColumnValues: (name)->
		values = []
		index = @getColumnIndex name
		data = _.pluck @getData(), 'values'
		values.push data[i][index] for i of data
		values

	getColumnSum: (name)-> @sum @getColumnValues(name)
	getColumnAvg: (name)-> @avg @getColumnValues(name)

	getSummaryRow: (data)->
		summary = []
		sum_fields = @getFieldsToSum()
		avg_fields = @getFieldsToAverage()
		columns = @getColumns()
		for i of columns
			summary[i] = '' unless summary[i]
			if _.indexOf(sum_fields, columns[i]) >= 0
				summary[i] = @getColumnSum columns[i]
			else if _.indexOf(avg_fields, columns[i]) >= 0
				summary[i] = @getColumnAvg columns[i]
		summary
			
