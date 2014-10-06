class ChaiIo.Views.Console extends ChaiIo.Views.Base
  events:
    'click #btn-run': 'runQuery'

  keyboardEvents:
    'command+shift+t': 'runQuery'
    'control+shift+t': 'runQuery'

  getDatasourceId: -> @$el.find('#datasource_id').val()
  getQuery: -> @$el.find('.query-editor').val().trim()

  handleError: (error)->


  showResult: (response) ->
    NProgress.done()
    if response.error
      @handlerError response.error
      return


  runQuery: ->
    NProgress.start()
    $.ajax '/console/run',
      data: { console: { query: @getQuery(), datasource_id: @getDatasourceId() }}
      dataType: 'json'
      success: (response) => @showResult(response)
