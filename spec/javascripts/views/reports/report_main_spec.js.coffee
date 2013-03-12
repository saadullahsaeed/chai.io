# use require to load any .js file available to the asset pipeline
#= require application
#= require reports

describe "Report Main View", ->

  main_view = null
  report_type_viw = null
  report_model = null

  report_fixture = getJSONFixture('report')
  report_with_filters_fixture = getJSONFixture('report_with_filters')
  server = null

  loadFixtures 'sharing_button_fixture'

  beforeEach ()=>
    el = $('#content')
    report_model = new ChaiIo.Models.Report().set report_fixture
    main_view = new ChaiIo.Views.ReportMain({model: report_model, el: el})
    report_type_view = new ChaiIo.Views.ReportsIndex({model: report_model})
    main_view.setReportTypeView report_type_view

  describe "when initializes", ->

    it "instantiates the filter view", ->
      expect(main_view.filter_view).toBeDefined()
      expect(main_view.filter_view instanceof ChaiIo.Views.ReportFiltersView).toBeTruthy()
      

  describe "to render", ->
    
    beforeEach ()=>
      main_view.filter_view.render = sinon.spy()
      main_view.reportTypeView.render = sinon.spy()
      main_view.renderSharingOptions = sinon.spy()
      main_view.delegateEvents = sinon.spy()
      main_view.render()

    it "initFilterView is called once to initialize filters", ->
      expect(main_view.filter_view.render).toHaveBeenCalledOnce()

    it "reportTypeView.render is called once", ->
      expect(main_view.reportTypeView.render).toHaveBeenCalledOnce()

    it "function to render sharing options is called", ->
      expect(main_view.renderSharingOptions).toHaveBeenCalledOnce()

    it "calls delegateEvents for backbone events", ->
      expect(main_view.delegateEvents).toHaveBeenCalledOnce()


  describe "for sharing", ->

    beforeEach ()=>
      main_view.setLoadingState = sinon.spy()
      main_view.sendRequest = sinon.spy()
      server = sinon.fakeServer.create()

    afterEach ()=>
      expect(main_view.sendRequest).toHaveBeenCalledOnce()
      server.restore()

    it "enable sharing sets the loading state and sends request to enable sharing", ->
      sinon.stub($, "ajax").yieldsTo("success", yes)
      main_view.showPublicURL = sinon.spy()
      main_view.enableSharing()

      expect(main_view.setLoadingState).toHaveBeenCalledWith main_view.$('#btn-enable-sharing')
      #put this in a helper
      #server.requests[0].respond 200, { "Content-Type": "application/json" }, JSON.stringify({ success: true})
      #expect(main_view.showPublicURL).toHaveBeenCalledOnce()

      
    it "disable sharing sets the loading state and sends request to disable sharing", ->
      main_view.disableSharing()
      expect(main_view.setLoadingState).toHaveBeenCalledWith main_view.$('#btn-disable-sharing')



  it "can create a report URL", ->
    expect(main_view.getReportURL()).toEqual "/reports/#{report_fixture.report.id}"

