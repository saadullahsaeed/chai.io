class ChaiIo.Views.ReportsListView extends Backbone.View
	constructor: (options)->
		@events = 
			'keyup #search_keywords': 'search'
			'keydown #search_keywords': 'search'
		super options
	
	search: (event)->
		search_term = $('#search_keywords').val()
		return @render() if search_term is ''
		@showList(@filterList search_term)
	
	getSearchFields: -> ['title', 'report_type']
	filterList: (searchTerm) ->
		searchFields = @getSearchFields()
		filtered = _.filter @model.toJSON(), (item)=>
			for field in searchFields
				return yes if item[field] && item[field].match(searchTerm)
			
		filtered
	
	render: -> 
		@showList @model.toJSON()
		@
		
	showList: (reportList)-> $('#dv_table').html(ich.list_main {reports: reportList})