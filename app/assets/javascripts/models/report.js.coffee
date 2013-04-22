class ChaiIo.Models.Report extends Backbone.Model
	isReportEmbedded: -> @get 'embedded'

	getReportConfig: -> @getReport().config || {}
	getReportConfigField: (field)-> @getReportConfig()[field] || ''
	getAggFields: (agg_type)-> @getReportConfigField(agg_type).split ','

	getReportId: -> @getReport().id
	getReport: -> @get 'report'
	setReport: (report)-> @set {report: report}

	getReportType: -> @get 'report_type'

	updateReport: (key, value)->
		report = @getReport()
		report[key] = value
		@setReport report

	getFieldsToSum: -> @getAggFields 'sum'
	getFieldsToAverage: -> @getAggFields 'average'

	isSharingEnabled: -> @getReport().sharing_enabled

	isReportLinked: -> @getLinkedReport() && @getLinkedColumn() && @getLinkedFilter()
	getLinkedReport: -> @getReportConfigField 'link_report'
	getLinkedColumn: -> @getReportConfigField 'link_column'
	getLinkedFilter: -> @getReportConfigField 'link_filter'
