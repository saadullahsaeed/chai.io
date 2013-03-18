# use require to load any .js file available to the asset pipeline
#= require application
#= require reports

describe "New Report View", ->

	new_report_view = null


	beforeEach ()=>
		new_report_view = new ChaiIo.Views.NewReport({el: $('.container')})
		new_report_view.alert = sinon.spy()
		new_report_view.notifyError = sinon.spy()
		

	describe "when initialized", ->
		it "will have id as the only reserved placeholder", ->
			expect(new_report_view.reservedPlaceholders()).toEqual ['id']


	describe "to render", ->
		beforeEach ()=>
			new_report_view.initQueryEditor = sinon.spy()
			new_report_view.render()

		it "initializes query editor", ->
			expect(new_report_view.initQueryEditor).toHaveBeenCalledOnce()


	describe "to submit report form", ->

		beforeEach ()=>
			new_report_view.copyQueryValue = sinon.spy()
			new_report_view.$('.form').submit = sinon.spy()
			new_report_view.validated = sinon.stub().returns yes
		
		it "copies query val from editor", ->
			new_report_view.submitForm()
			expect(new_report_view.copyQueryValue).toHaveBeenCalledOnce()


		describe "if validation fails", ->
			beforeEach ()=>
				new_report_view.validated = sinon.stub().returns no
				new_report_view.submitForm()
	
			it "stops form submit if validation fails", ->
				expect(new_report_view.$('.form').submit).not.toHaveBeenCalledOnce()


		describe "if validation succeeds", ->
			beforeEach ()=>
				new_report_view.validated = sinon.stub().returns yes
				new_report_view.submitForm()
	
			it "calls form submit if validated", ->
				#expect(new_report_view.$).toHaveBeenCalledOnce()
		

	describe  "to validate", ->
		beforeEach ()=>
			loadFixtures 'new_report_fixture.html'

		it "checks placeholders", ->
			new_report_view.checkPlaceholders = sinon.spy()
			new_report_view.checkAggFields = sinon.spy()
			new_report_view.validated()
			expect(new_report_view.checkPlaceholders).toHaveBeenCalledOnce()
		

		it "checks agg only if check placeholders passes", ->
			new_report_view.checkPlaceholders = sinon.stub().returns yes
			new_report_view.checkAggFields = sinon.spy()
			new_report_view.validated()
			expect(new_report_view.checkAggFields).toHaveBeenCalledOnce()


		it "does not validate if check placeholders returns false", ->
			new_report_view.checkPlaceholders = sinon.stub().returns no
			new_report_view.checkAggFields = sinon.spy()
			validation_result = new_report_view.validated()
			expect(validation_result).toBeFalsy()
			expect(new_report_view.checkAggFields).not.toHaveBeenCalledOnce()


		it "check placeholders to return yes if no values set", ->
			expect(new_report_view.checkPlaceholders()).toBeTruthy()


		it "checks if a given placeholder is reserved", ->
			expect(new_report_view.isReservedPlaceholder('id')).toBeTruthy()
			expect(new_report_view.isReservedPlaceholder('xid')).toBeFalsy()


		it "fails validation if 'id' defined as placeholder", ->
			$('#report_filters_placeholder1').val "id"
			new_report_view.isPlaceholderInQuery = sinon.stub().returns yes
			expect(new_report_view.checkPlaceholders()).toBeFalsy()
			expect(new_report_view.alert).toHaveBeenCalledOnce()
			expect(new_report_view.notifyError).toHaveBeenCalledOnce()

			$('#report_filters_placeholder1').val "xid"
			expect(new_report_view.checkPlaceholders()).not.toBeFalsy()





