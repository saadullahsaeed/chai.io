class ChaiIo.Views.ReportMain extends ChaiIo.Views.Base
	constructor: (options)->
		@events =
			'click #btn-public-url': 'enableSharing'
			'click #btn-enable-sharing': 'enableSharing'
			'click #btn-disable-sharing': 'disableSharing'
		super options
		
	setReportTypeView: (view)-> @setThisAsParentView(@reportTypeView = view)
	
	isEmbedded: -> @model.isReportEmbedded()
	
	render: ->
		@initFilterView() unless @isEmbedded()
		@reportTypeView.render() if @reportTypeView
		@renderSharingOptions() unless @isEmbedded()
		@delegateEvents()
	
	filtersContainer: -> $('#dv_filters')
	initFilterView: ->
		@filter_view = new ChaiIo.Views.ReportFiltersView {el: @filtersContainer(), model: @model}
		@filter_view.render()
	
	getReportURL: ->"/reports/#{@model.getReportId()}"
		
	disableSharing: (event)->
		@$('#btn-disable-sharing').button 'loading'
		@sendRequest "#{@getReportURL()}/unshare", {}, (response)=>
			@model.updateReport 'sharing_enabled', no
			@renderSharingOptions()
			
	enableSharing: (event)-> 
		@$('#btn-enable-sharing').button 'loading'
		@sendRequest "#{@getReportURL()}/share", {}, (response)=>
			if response
				@showPublicURL response.public_url 
				@model.updateReport 'sharing_enabled', yes
				@renderSharingOptions()
		
	showPublicURL: (url)->
		@$('#txt_public_url').val url
		@$('#aSharingModal').click()
		
	renderSharingOptions: -> 
		@$('#sharing_container').html(ich.tpl_sharing {report: @model.getReport()})
		@$('#btn-enable-sharing').button 'reset'
		@$('#btn-disable-sharing').button 'reset'
	