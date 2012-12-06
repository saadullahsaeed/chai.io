class ChaiIo.Views.Base extends Backbone.View

	getSearchFields: -> []	
	
	filterList: (searchTerm, data) ->
		searchFields = @getSearchFields()
		filtered = _.filter data, (item)=>
			for field in searchFields
				return yes if item[field] && item[field].toLowerCase().match searchTerm.toLowerCase()
		filtered
	