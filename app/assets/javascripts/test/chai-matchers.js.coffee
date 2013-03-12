#Custom matchers for chai jasmine testing
#
beforeEach ()=>
	custom_matchers = 
		toBeInstanceOf: (expected)->
			message: -> "Not an insance of #{expected}"
			@actual instanceof expected
	#console.log custom_matchers
	#@addMatchers custom_matchers