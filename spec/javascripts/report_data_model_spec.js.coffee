# use require to load any .js file available to the asset pipeline
#= require application
#= require reports

describe "Report Data Model", ->
  loadFixtures 'example_fixture' # located at 'spec/javascripts/fixtures/example_fixture.html.haml'
  it "it returns the correct report type", ->
    r = new ChaiIo.Models.Report()
    r.set {report_type: 'table'}
    expect(r.getReportType()).toEqual('table')