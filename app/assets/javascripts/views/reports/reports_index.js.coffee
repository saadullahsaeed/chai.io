class ChaiIo.Views.ReportsIndex extends Backbone.View
	
	preRender: ->
	
	postRender: ->
	
	render: ->
		@preRender()
		templateName = @getTemplateName()
		return no if templateName is ''
		$(@el).html(ich[templateName] @getModelJSON())
		@postRender()
		yes
	
	getTemplateName: -> "report_#{@model.get('report_type')}"
	
	getModelJSON: -> @model.toJSON()
	getColumns: -> @model.get 'columns'
	getData: -> @model.get 'data'
