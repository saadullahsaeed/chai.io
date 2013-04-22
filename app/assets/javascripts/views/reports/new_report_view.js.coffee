class ChaiIo.Views.NewReport extends ChaiIo.Views.Base
	constructor: (options)->
		@events =
			'submit .form': 'copyQueryValue'
			'click #commit': 'submitForm'
			'change input[type=radio]': 'reportTypeChanged'
		super options
	
	render: -> 
		@initQueryEditor()
		@initAdvancedSettings()

	initAdvancedSettings: ->
		view = new ChaiIo.Views.ReportSettingsView({el: $('form')})
		view.render()
		
	initQueryEditor: ->
		@editor = ace.edit "editor"
		@editor.setTheme "ace/theme/textmate"
		@editor.getSession().setMode "ace/mode/sql"
		@editor.setValue @getQueryTAValue()
		@editor.getSession().on('change', (e)=> )
		unless @getEditorValue() is ''
			@editor.selection.setSelectionRange {start:0, end:0}
			

	getQueryTextArea: -> $('#query')
	getQueryTAValue: -> @getQueryTextArea().val()
	getEditorValue: -> @editor.getValue()
	copyQueryValue: (event)-> @getQueryTextArea().val @getEditorValue()

	getConfigField: (field)-> $("#report_config_#{field}").val().trim()
		
	submitForm: ->
		@copyQueryValue()
		$('.form').submit() if @validated()
		
	reservedPlaceholders: -> ['id']
	isReservedPlaceholder: (ph) -> _.indexOf(@reservedPlaceholders(), ph) >= 0
	isPlaceholderInQuery: (ph) -> @getQueryTAValue().concat(' ').match(":#{ph}[$|;|,|\ ]") != null
	checkPlaceholders: ->
		placeholders = $('input[id*=report_filters_placeholder]')
		for ph in placeholders
			ph_value = $(ph).val()
			continue if ph_value is ''
			if @isReservedPlaceholder ph_value
				@alert "Placeholder '#{ph_value}' is a reserved parameter and cannot be used as a placeholder"
				@notifyError "Invalid Placeholder"
				return no
			unless @isPlaceholderInQuery ph_value
				@alert "Placeholder '#{ph_value}' is not present in the query"
				@notifyError "Invalid Placeholder"
				return no
		yes


	checkAggFields: ->
		return yes if @getConfigField('sum').length is 0 and @getConfigField('average').length is 0
		sum_fields = @getConfigField('sum').split ','
		avg_fields = @getConfigField('average').split ','
		common = _.intersection sum_fields, avg_fields
		if common.length > 0
			@alert "Following field(s) can either belong to sum or average but not both: <br/> #{common}"
			@notifyError "Invalid Aggregation fields"
			return no
		yes

	
	validated: ->
		return no unless @checkPlaceholders()
		return no unless @checkAggFields()
		yes
	
	queryStructure: ->

	hideAggregationConfig: -> $('#aggregation_config').hide()
	showAggregationConfig: -> $('#aggregation_config').show()

	reportTypeChanged: (event)->

	hasPlaceholderValues: -> 
		for ph_val in $('input[id*=report_filters_placeholder]')
			return yes if  $(ph_val).val() and $(ph_val).val().trim() isnt ''
		no

	preFillPlaceholders: (event)-> return if @hasPlaceholderValues()

