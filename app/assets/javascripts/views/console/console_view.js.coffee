class ChaiIo.Views.Console extends ChaiIo.Views.Base
  events:
    'click #btn-run': 'runQuery'
    'click #btn-save-report': 'saveReport'

  keyboardEvents:
    'command+shift+t': 'runQuery'
    'control+shift+t': 'runQuery'

  getProjectId: -> @$el.find('#project_id').val()
  getDatasourceId: -> @$el.find('#datasource_id').val()
  getQuery: -> @$el.find('.query-editor').val().trim()

  handleError: (error)->
    alert error

  prepareReportModel: ()->
    report = new ChaiIo.Models.Report()
    report.set({report: {}, report_type: 'table'})
    report

  prepareReportDataModel: (result)->
    report_data = new ChaiIo.Models.ReportData()
    report_data.set({data: result.data, columns: result.columns})
    report_data

  showResult: (response) ->
    NProgress.done()
    if response.error
      @handleError response.error
      return
    result_view = new ChaiIo.Views.ReportsTable({
      model: @prepareReportModel()
      el: $('#dv-results')
    })
    result_view.setReportData @prepareReportDataModel(response)
    result_view.render()
    @$el.find('.form-search').hide()

  validateQuery: -> @getQuery() isnt ''

  runQuery: ->
    unless @validateQuery()
      alert "Invalid Query"
      return
    NProgress.start()
    $.ajax '/console/run',
      data: { console: { query: @getQuery(), datasource_id: @getDatasourceId() }}
      dataType: 'json'
      method: 'POST'
      success: (response) => @showResult(response)

  saveReport: ->
    unless @validateQuery()
      alert "Invalid Query"
      return
    project_id = @getProjectId()
    unless project_id
      alert "Please select a project to proceed!"
      return
    query = encodeURIComponent window.btoa(@getQuery())
    datasource_id = @getDatasourceId()
    query_str = "q=#{query}&ds=#{datasource_id}"
    top.location = "/projects/#{project_id}/reports/new?#{query_str}"
