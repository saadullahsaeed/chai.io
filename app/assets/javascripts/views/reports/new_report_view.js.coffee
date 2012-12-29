class ChaiIo.Views.NewReport extends ChaiIo.Views.Base
	constructor: (options)->
		@events =
			'submit .form': 'copyQueryValue'
			'click #commit': 'submitForm'
		super options
	
	render: ->
		@initQueryEditor()
		
	initQueryEditor: ->
		@editor = ace.edit "editor"
		@editor.setTheme "ace/theme/textmate"
		@editor.getSession().setMode "ace/mode/sql"
		@editor.setValue @getQueryTAValue()
		unless @getEditorValue() is ''
			@editor.selection.setSelectionRange {start:0, end:0}
		
	getQueryTextArea: -> $('#query')
	getQueryTAValue: -> @getQueryTextArea().val()
	getEditorValue: -> @editor.getValue()
	copyQueryValue: (event)-> @getQueryTextArea().val @getEditorValue()
		
	submitForm: ->
		@copyQueryValue()
		$('.form').submit() if @validated()
		
	reservedPlaceholders: -> ['id']
	isReservedPlaceholder: (ph) -> _.indexOf(@reservedPlaceholders(), ph) >= 0
	isPlaceholderInQuery: (ph) -> @getQueryTAValue().concat(' ').match(":#{ph}[,|\ ]") != null
	checkPlaceholders: ->
		placeholders = $('input[id*=report_filters_placeholder]')
		for ph in placeholders
			ph_value = $(ph).val()
			continue if ph_value is ''
			if @isReservedPlaceholder ph_value
				alert "#{ph_value} is a reserved parameter and cannot be used as a placeholder"
				return no
			if not @isPlaceholderInQuery ph_value
				alert "Placeholder #{ph_value} is not present in the query"
				return no
		yes
	
	validated: ->
		return no unless @checkPlaceholders()
		yes
		
		
		
		
		