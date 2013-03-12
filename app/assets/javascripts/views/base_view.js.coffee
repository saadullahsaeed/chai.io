class ChaiIo.Views.Base extends Backbone.View
	constructor: (options)->
		@parentView = null
		super options

	getSearchFields: -> []	
	
	filterList: (searchTerm, data) ->
		searchFields = @getSearchFields()
		filtered = _.filter data, (item)=>
			for field in searchFields
				return yes if item[field] && item[field].toLowerCase().match searchTerm.toLowerCase()
		filtered
	
	sendRequest: (url, params, onSucc, onFail, method)->
		options = 
			data: params
			type: method || 'GET'
			dataType: 'json'
		xhr = $.ajax "#{url}.json", options
		xhr.done onSucc if onSucc
		xhr.fail onFail if onFail
	
	requestPut: (url, params, onSucc, onFail)-> @sendRequest url, params, onSucc, onFail, 'PUT'
	
	showLoading: ->
	hideLoading: ->	
	
	getModelJSON: -> @model.toJSON()	

	alert: (msg)-> alertify.alert msg
	notifyError: (msg)-> alertify.error msg
	notifySuccess: (msg)-> alertify.success msg
	confirm: (msg)->
		alertify.set { buttonFocus: "cancel" }
		alertify.confirm msg

	hasParentView: -> @parentView isnt null
	setThisAsParentView: (view)-> 
		view.parentView = @
		view