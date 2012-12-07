class ChaiIo.Views.NewReport extends ChaiIo.Views.Base
	constructor: (options)->
		@events =
			'submit .form': 'copyQueryValue'
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
	copyQueryValue: -> 
		@getQueryTextArea().val @getEditorValue()
		yes
		
		
		
		