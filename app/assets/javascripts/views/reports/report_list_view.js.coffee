class ChaiIo.Views.ReportsListView extends ChaiIo.Views.Base
	constructor: (options)->
		@events = 
			'keyup #search_keywords': 'search'
			'keydown #search_keywords': 'search'
			'click .star': 'starReport'
		super options
	
	search: (event)->
		search_term = $('#search_keywords').val()
		return @render() if search_term is ''
		@showList(@filterList search_term, @model.toJSON())
	
	getSearchFields: -> ['title', 'report_type']
	
	render: -> 
		@showList @model.toJSON()
		@delegateEvents()
		@
		
	showList: (reportList)-> $('#dv_table').html(ich.list_main {reports: reportList})

	starReport: (event)->
		target = $ event.currentTarget
		img = $(target.children()[0])
		report_id = target.attr 'data-report-id'
		report = @model.get report_id
		@sendRequest "/reports/#{report_id}/star", {}, ()=> @starred()
		if report.get 'starred'
			img.attr 'src', '/assets/star4.png'
		else
			img.attr 'src', '/assets/star-lit4.png'
		report.set {starred: !(report.get 'starred')}

	starred: ->


