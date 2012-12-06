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
		
	showTable: (data)-> @renderTpl 'tpl_table_body', $('#tbody'), {data: data}
	
	filterData: (searchTerm)-> 
		data = @getData()
		filtered = _.filter data, (item)=>
			for val in item.values
				val = "#{val}" if typeof val isnt 'string'
				return yes if val.toLowerCase().indexOf(searchTerm.toLowerCase(0)) >= 0
		filtered