class ChaiIo.Views.ReportsListView extends ChaiIo.Views.Base
	constructor: (options)->
		@events = 
			'keyup #search_keywords': 'search'
			'keydown #search_keywords': 'search'
		super options
	
	search: (event)->
		search_term = $('#search_keywords').val()
		return @render() if search_term is ''
		@showList(@filterList search_term, @model.toJSON())
	
	getSearchFields: -> ['title', 'report_type']
	
	render: -> 
		@showList @model.toJSON()
		@
		
	showList: (reportList)-> $('#dv_table').html(ich.list_main {reports: reportList})