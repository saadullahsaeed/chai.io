class ChaiIo.Views.Console extends ChaiIo.Views.Base
  events:
    'click #btn-run': 'runQuery'
    'click #btn-save-report': 'saveReport'

  keyboardEvents:
    'command+shift+t': 'runQuery'
    'control+shift+t': 'runQuery'

  getDatasourceId: -> @$el.find('#datasource_id').val()
  getQuery: -> @$el.find('.query-editor').val().trim()

  handleError: (error)->

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
      @handlerError response.error
      return
    result_view = new ChaiIo.Views.ReportsTable({
      model: @prepareReportModel()
      el: $('#dv-results')
    })
    result_view.setReportData @prepareReportDataModel(response)
    result_view.render()
    @$el.find('.form-search').hide()

  runQuery: ->
    NProgress.start()
    $.ajax '/console/run',
      data: { console: { query: @getQuery(), datasource_id: @getDatasourceId() }}
      dataType: 'json'
      success: (response) => @showResult(response)

  saveReport: ->
    alert "sorry this is not yet implemented!"
