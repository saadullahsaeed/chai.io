# use require to load any .js file available to the asset pipeline
#= require application
#= require reports

describe "Base View", ->
  
  base_view = null

  beforeEach ()=>
    base_model = new ChaiIo.Models.Base()
    base_view = new ChaiIo.Views.Base({model: base_model})

  describe "when initialized", ->

    it "should have parentView as null", ->
      expect(base_view.parentView).toBe null

    it "should have search fields as an empty array", ->
      expect(base_view.getSearchFields()).toEqual []
      

  it "can filter a list for a given term on set search fields", ->
    base_view.getSearchFields = ()=> ['test_field']
    data_to_filter = [
      {test_field: "first item"},
      {test_field: "second item"},
      {test_field: "third item"}
    ]
    expect(base_view.filterList 'first', data_to_filter).toEqual [data_to_filter[0]]
    expect(base_view.filterList 'third', data_to_filter).toEqual [data_to_filter[2]]
    expect(base_view.filterList 'item', data_to_filter).toEqual data_to_filter

  it "can tell if it has a parent view", ->
    expect(base_view.hasParentView()).toBe no
    child_view = new ChaiIo.Views.Base()
    parent_view = new ChaiIo.Views.Base()
    child_view = parent_view.setThisAsParentView child_view
    expect(child_view.hasParentView()).toBe yes

  it "can return model data as JSON", ->
    test_json = {testing: yes}
    base_view.model.set test_json
    expect(base_view.getModelJSON()).toEqual test_json
  

