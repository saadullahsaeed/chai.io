class ChaiIo.Views.ReportsSingle_value extends ChaiIo.Views.ReportsIndex
	
	preRender: ->
		data = @getData()
		columns = @getColumns()
		
		col = columns.shift()
		first_row = data.shift()
		@model.set {single_column_name: col, single_value: first_row[col]}
		 
	getTemplateName: -> "report_single_value"
	
	
	
