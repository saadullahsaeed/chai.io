# use require to load any .js file available to the asset pipeline
#= require application
#= require reports

describe "Reports Bar & Line Chart View", ->

	report_view = null


	beforeEach ()=>
		report_view = new ChaiIo.Views.ReportsBar_line_chart()


	it "requires nested data values", ->
		expect(report_view.hasNestedDataValues()).toBeTruth()



