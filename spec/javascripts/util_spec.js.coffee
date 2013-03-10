# use require to load any .js file available to the asset pipeline
#= require application
#= require reports

describe "Util specs", ->
  it "sums the array", ->
    array_sum = ChaiIo.Util.sum [1, 2, 3]
    expect(array_sum).toEqual(6)