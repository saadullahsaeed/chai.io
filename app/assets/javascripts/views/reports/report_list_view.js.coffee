class ChaiIo.Views.ReportsListView extends Backbone.View
	constructor: (options)->
		@events = 
			'click #report_search': 'searchX'
		super options
	
	searchX: (event)->
		search_term = $ '#search_keywords'
		