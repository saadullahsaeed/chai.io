class ChaiIo.Views.ReportsSingle_value extends ChaiIo.Views.ReportsIndex
	
	preRender: ->
		col = @report_data.getFirstColumn()
		first_row = @report_data.getFirstRow()
		@report_data.set {single_column_name: col, single_value: first_row[col]}
		 
	getTemplateName: -> "report_single_value"
	
	
	
