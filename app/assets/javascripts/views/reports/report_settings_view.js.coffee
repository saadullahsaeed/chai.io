class ChaiIo.Views.ReportSettingsView extends ChaiIo.Views.Base
	constructor: (options)->
		@events =
			'click #tabSettings a': 'switchTab'
		super options

	render: -> 
		$(@el).append ich.tpl_settings({})
		@delegateEvents()
	

	switchTab: (e)->
		e.preventDefault()
		$(e.currentTarget).tab 'show'
