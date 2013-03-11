# use require to load any .js file available to the asset pipeline
#= require application
#= require reports

describe "Util specs", ->
  it "sums the array", ->
    array_sum = ChaiIo.Util.sum [1, 2, 3]
    expect(array_sum).toEqual(6)

  it "parses int while summing array", ->
  	array_sum = ChaiIo.Util.sum ['1', '2', 3]
  	expect(array_sum).toEqual(6)

  it "calculates avg of an array", ->
  	array_avg = ChaiIo.Util.avg [3, 2, 3]
  	expect(array_avg).toEqual(3)
  
  it "caclulates avg of an array and parses int too", ->
  	array_avg = ChaiIo.Util.avg [3, 2, '3']
  	expect(array_avg).toEqual(3)

  it "converts date to unix timestamp", ->
  	date = '2013-01-01'
  	d = new Date(2013, 0, 1)
  	expect(ChaiIo.Util.dateToTime date).toEqual(d.getTime())