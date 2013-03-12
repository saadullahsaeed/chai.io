# use require to load any .js file available to the asset pipeline
#= require application
#= require reports

describe "Reports Index View", ->

  report_view = null
  report_model = null
  report_data = null
  report_data_fixture = getJSONFixture('report_data')
  report_fixture = getJSONFixture('report')

  beforeEach ()=>
    report_model = new ChaiIo.Models.Report().set report_fixture
    report_data = new ChaiIo.Models.ReportData().set report_data_fixture
    report_view = new ChaiIo.Views.ReportsIndex({model: report_model})


  describe "when initialized", ->
    it "will have nested data values flag set to no", ->
      expect(report_view.hasNestedDataValues()).toBe no


  it "can make template name with the report type", ->
    expect(report_view.getTemplateName()).toEqual "report_#{report_fixture.report_type}"


  it "returns false if renderTpl is called with no template name", ->
    expect(report_view.renderTpl '', null, []).toBeFalsy()


  describe "when set with report data", ->
    beforeEach ()=>
      report_view.setReportData report_data

    it "can get columns from report data", ->
      expect(report_view.getColumns()).toEqual report_data_fixture.columns


  describe "to render", ->
    beforeEach ()=>
      report_view.preRender = sinon.spy()
      report_view.postRender = sinon.spy()
      report_view.reRenderTpl = sinon.spy()

    it "calls preRender exactly one before rendering", ->
      report_view.render()
      expect(report_view.preRender).toHaveBeenCalledOnce()
      report_view.preRender()
      expect(report_view.preRender).toHaveBeenCalledTwice()

    it "calls reRenderTpl exactly one to render after preRender", ->
      report_view.render()
      expect(report_view.preRender).toHaveBeenCalledOnce()
      expect(report_view.reRenderTpl).toHaveBeenCalledOnce()

    it "calls postRender exactly one to render", ->
      report_view.render()
      expect(report_view.preRender).toHaveBeenCalledOnce()
      expect(report_view.reRenderTpl).toHaveBeenCalledOnce()
      expect(report_view.postRender).toHaveBeenCalledOnce()

    describe "for nested values", ->

      beforeEach ()=>
        report_view.hasNestedDataValues = sinon.stub().returns yes
        report_view.setReportData report_data

      it "calls set data if nest data values is enabled", ->
        report_view.setData = sinon.spy()
        report_view.render()
        expect(report_view.setData).toHaveBeenCalledOnce()
        
      it "nests data if nest data values is enabled", ->
        report_view.render()
        nested_data = report_data.nestDataValues()
        #expect(report_view.getData()).toEqual nested_data





