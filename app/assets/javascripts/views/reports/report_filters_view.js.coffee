class ChaiIo.Views.ReportFiltersView extends ChaiIo.Views.Base
	constructor: (options)->
    @events = 
      'click .btn-pd-filter': 'applyPdFilterValue'
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
      pd_values = []
      for i, pv of filter['pd_values']
        if pv['title'] && pv['value']
          pv['placeholder'] = placeholder
          pd_values.push pv
      formatted.push { label: placeholder, filter_control: filter_control, pd_values: pd_values } 
		formatted
	
	render: ->
    $(@el).html(ich.tpl_filters {filters: @getFormattedFilters()})
    @initFilters()
    @delegateEvents()
	
  applyPdFilterValue: (event)->
    button = $ event.currentTarget
    val = button.attr 'data-value'
    ph = button.attr 'data-filter'
    filter_el = $ "input[name=#{ph}]"
    filter_el.val val
    $('#form_filters').submit()
    