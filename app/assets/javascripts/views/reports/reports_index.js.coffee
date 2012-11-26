class ChaiIo.Views.ReportsIndex extends Backbone.View
	
	preRender: ->
	
	postRender: ->
	
	render: ->
		@preRender()
		templateName = @getTemplateName()
		return no if templateName is ''
		$(@el).html ich[templateName] @getData()
		@postRender()
		yes
	
	getTemplateName: -> "report_#{@model.get('report_type')}"
	
	getData: -> @model.toJSON()