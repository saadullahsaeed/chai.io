# use require to load any .js file available to the asset pipeline
#= require application
#= require reports

describe "Report Model", ->
  
  report = null	
  fixture = getJSONFixture('report')

  beforeEach ()=>
  	report = new ChaiIo.Models.Report()
  	report.set fixture

  it "returns the report_type set", -> 
    expect(report.getReportType()).toBe fixture.report_type

  it "returns the report", ->
    expect(report.getReport()).toBe fixture.report

  it "can tell if report is embedded (public)", ->
    expect(report.isReportEmbedded()).toBe 0
    embedded_report = fixture
    embedded_report.embedded = 1
    report.set embedded_report
    expect(report.isReportEmbedded()).toBe 1

  it "allows updates", ->
    expect(report.getReport().title).toBe "My Report Fixture"
    new_title = 'Title Updated'
    report.updateReport 'title', new_title
    expect(report.getReport().title).toBe new_title

  it "can tell if sharing is enabled in report config", ->
    expect(report.isSharingEnabled()).toBe 0
    report.updateReport 'sharing_enabled', 1
    expect(report.isSharingEnabled()).toBe 1

  it "can tell the id of the report", ->
    expect(report.getReportId()).toBe 1
    report.updateReport 'id', 5
    expect(report.getReportId()).toBe 5

  it "can return fields configured for agg after converting str to array", ->
    expect(report.getAggFields 'sum').toEqual ["count"]

  it "can tell what fields are configured to for summary sum", ->
    expect(report.getFieldsToSum()).toEqual fixture.report.config.sum.split(',')

  it "can tell what fields are configured to for summary average", ->
    expect(report.getFieldsToAverage()).toEqual fixture.report.config.average.split(',')

  it "can return any config field", ->
    expect(report.getReportConfigField 'sum').toEqual fixture.report.config.sum
    expect(report.getReportConfigField 'average').toEqual fixture.report.config.average

  it "will return empty string is a config field is not present", ->
    expect(report.getReportConfigField 'does_not_exist_in_the_fixture').toEqual ''

  it "returns empty object (hash) if config is null", ->
    report.updateReport 'config', null
    expect(report.getReportConfig()).toEqual {}




  