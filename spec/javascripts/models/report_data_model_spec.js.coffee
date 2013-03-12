# use require to load any .js file available to the asset pipeline
#= require application
#= require reports

describe "Report Data Model", ->
  
  report_data = null	
  fixture = getJSONFixture('report_data')

  beforeEach ()=>
  	report_data = new ChaiIo.Models.ReportData()
  	report_data.set fixture
  	
  it "returns total number of columns via totalColumns", ->
  	expect(report_data.totalColumns()).toEqual fixture.columns.length

  it "returns column index given column name via getColumnIndex", ->
  	expect(report_data.getColumnIndex('id')).toEqual 0
  	expect(report_data.getColumnIndex('user_id')).toEqual 1
  	expect(report_data.getColumnIndex('report_id')).toEqual 2
  	expect(report_data.getColumnIndex('project_id')).toEqual 3

  it "trims whitespace before finding column index", ->
  	expect(report_data.getColumnIndex('user_id   ')).toEqual 1

  it "returns columns as array via getColumns", ->
  	expect(report_data.getColumns()).toEqual fixture.columns

  it "returns array of indices for given column list via getColumnsIndices", ->
  	expect(report_data.getColumnsIndices ['id','project_id']).toEqual [0, 3]
  	expect(report_data.getColumnsIndices ['user_id','id ']).toEqual [1, 0]

  it "return result data via getData", ->
  	expect(report_data.getData()).toEqual fixture.data

  it "allows setting of data via setData", ->
  	new_data = [{new_data: 1}]
  	report_data.setData new_data
  	expect(report_data.getData()).toEqual new_data

  it "can find the first column from the column set", ->
  	expect(report_data.getFirstColumn()).toEqual 'id'

  it "can find the first row from the data set", ->
  	expect(report_data.getFirstRow()).toEqual fixture.data[0]


  it "can set a summary row and verify has_summary is set", ->
    summary_row = [{total: 100}]
    report_data.setSummaryRow summary_row
    expect(report_data.getSummaryRow()).toEqual summary_row
    expect(report_data.get 'has_summary').toBe yes


  describe "with nested data valutes", ->

    beforeEach ()=>
      report_data.setDataAsNestedValues()

    it "can sum number column values via getColumnSum", ->
    	expect(report_data.getColumnSum 'user_id').toEqual 3
    	
    it "can filter result data for a given search term across all columns", ->
    	expect(report_data.filterData(fixture.data[2].title)).toEqual [report_data.getData()[2]]
    	expect(report_data.filterData(fixture.data[1].title)).toEqual [report_data.getData()[1]]
    	expect(report_data.filterData(fixture.data[0].title)).toEqual [report_data.getData()[0]]
    	
    it "can sort the data in asc order", ->
    	column_index = report_data.getColumnIndex 'id'
    	sorted = report_data.sortModel column_index
    	expect(sorted[0].values[column_index]).toEqual fixture.data[0].id


