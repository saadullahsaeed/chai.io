class ChaiIo.Views.ReportsDetails extends ChaiIo.Views.ReportsIndex
  getTemplateName: -> "report_details"

  preRender: -> 
    columns = @getColumns()
    data = @getData()
    return unless data.length > 0
    first_row = data[0]
    formatted = []
    for col_name in columns
      formatted.push({column: col_name, value: first_row[col_name]})
    @setData formatted