class ChaiIo.Models.ReportData extends Backbone.Model
	getColumns: -> @get 'columns'
	getColumnIndex: (column_name)-> _.indexOf @getColumns(), column_name.trim()
	getColumnsIndices: (columns_list)-> 
		mapped = []
		for column_name in columns_list
			index = @getColumnIndex column_name
			mapped.push(index) if index > -1
		mapped

	getColumnValues: (name)->
		values = []
		index = @getColumnIndex name
		data = _.pluck @getData(), 'values'
		values.push data[i][index] for i of data
		values

	totalColumns: -> @getColumns().length
	getColumnSum: (name)-> ChaiIo.Util.sum @getColumnValues(name)
	getColumnAvg: (name)-> ChaiIo.Util.avg @getColumnValues(name)

	getData: -> @get 'data'
	setData: (data)-> @set {data: data}

	setSummaryRow: (summary_row)-> @set {has_summary: yes, summary: summary_row}
	getSummaryRow: -> @get 'summary'

	sortModel: (colIndex, order = "asc")->
		return if colIndex is no
		_.sortBy @getData(), (obj)=> obj.values[colIndex]

	filterData: (searchTerm)-> 
		filtered = _.filter @getData(), (item)=>
			for val in item.values
				val = "#{val}" if typeof val isnt 'string'
				return yes if val.toLowerCase().indexOf(searchTerm.toLowerCase(0)) >= 0
		filtered

	setDataAsNestedValues: -> @setData @nestDataValues()
	nestDataValues: ->
		data = @getData()
		nested = []
		for row in data
			temp = []
			temp.push row[val] for val of row
			nested.push {values: temp}
		nested

	getFirstColumn: -> @getColumns()[0]
	getFirstRow: -> @getData()[0]