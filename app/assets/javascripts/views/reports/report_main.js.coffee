class ChaiIo.Views.ReportMain extends ChaiIo.Views.Base
	constructor: (options)->
		@events =
			'click #btn-public-url': 'enableSharing'
			'click #btn-enable-sharing': 'enableSharing'
			'click #btn-disable-sharing': 'disableSharing'
		super options
		
	setReportTypeView: (view)-> @reportTypeView = view
	
	render: ->
		@initFilterView()
		@reportTypeView.render() if @reportTypeView
		@renderSharingOptions()
		@delegateEvents()
	
	filtersContainer: -> $('#dv_filters')
	initFilterView: ->
		@filter_view = new ChaiIo.Views.ReportFiltersView {el: @filtersContainer(), model: @model}
		@filter_view.render()
	
	getReportId: -> @getReport().id
	getReport: -> @model.get 'report'
	getReportURL: ->"/reports/#{@getReportId()}"
	
	isSharingEnabled: -> @getReport().sharing_enabled
	updateReport: (key, value)-> 
		report = @getReport()
		report[key] = value
		@model.set {report: report}
		
	disableSharing: (event)->
		$('#btn-disable-sharing').button 'loading'
		@sendRequest "#{@getReportURL()}/unshare", {}, (response)=>
			@updateReport 'sharing_enabled', no
			@renderSharingOptions()
			
	enableSharing: (event)-> 
		$('#btn-enable-sharing').button 'loading'
		@sendRequest "#{@getReportURL()}/share", {}, (response)=>
			if response
				@showPublicURL response.public_url 
				@updateReport 'sharing_enabled', yes
				@renderSharingOptions()
		
	showPublicURL: (url)->
		$('#txt_public_url').val url
		$('#aSharingModal').click()
		
	renderSharingOptions: -> 
		$('#sharing_container').html(ich.tpl_sharing {report: @getReport()})
		$('#btn-enable-sharing').button 'reset'
		$('#btn-disable-sharing').button 'reset'
	