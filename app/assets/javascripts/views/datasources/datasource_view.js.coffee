class ChaiIo.Views.NewDatasource extends ChaiIo.Views.Base
	constructor: (options)->
		@events =
			'click #btn_test_connection': 'testConnection'
		super options

	getConfig: (field)-> $("#datasource_config_#{field}").val()
	getHost: -> @getConfig 'host'
	getUser: -> @getConfig 'user'
	getPassword: -> @getConfig 'password'
	getDatabase: -> @getConfig 'database'

	getCredentialsFromForm: ->
		cred = 
			host: @getHost()
			user: @getUser()
			password: @getPassword()
			database: @getDatabase()
		cred

	getParams: -> { datasource: { config: @getCredentialsFromForm() } }
	testConnection: -> @sendRequest('/datasources/test', @getParams(), ((json)=>@testOnLoad(json)), no, 'POST')
	testOnLoad: (response)-> 
		if response.success
			@notifySuccess "Connection test Successful!!"
		else
			@notifyError "Connection test failed!!"
