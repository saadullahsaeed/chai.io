class ChaiIo.Views.ReportFiltersView extends ChaiIo.Views.Base
	constructor: (options)->
		super options
	
	getFilterDateFormat: -> "yyyy-mm-dd"
	initDateFilters: -> $('.datepicker').datepicker {"format": @getFilterDateFormat()}
	
	initFilters: -> @initDateFilters()
	
	getFormattedFilters: ->
		formatted = []
		filters = @model.get 'filters'
		qparams = @model.get 'qparams'
		for i, filter of filters
			placeholder = filter['placeholder']
			continue unless placeholder
			value = qparams[placeholder]
			filter_control = ich["f_ctl_#{filter['control_type']}"]({placeholder: placeholder, value: value}, yes)
			formatted.push {label: placeholder, filter_control: filter_control} 
		formatted	
	
	render: ->
		$(@el).html(ich.tpl_filters {filters: @getFormattedFilters()})
		@initFilters()
		