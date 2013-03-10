class ChaiIo.Util
	constructor: ()->
	@dateToTime: (dt)->
		dt = dt.toString().split "-"
		month = parseInt(dt[1]) - 1;
		(new Date(dt[0], month, dt[2])).getTime()

	@sum: (arr)-> _.reduce arr, ((memo, num)=> return memo + parseInt(num)), 0
	@avg: (arr)-> Math.round(Util.sum(arr) / arr.length)