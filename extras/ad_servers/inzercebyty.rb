# jihomoravsky kraj
@base = "http://www.inzercebyty.cz/"

#@debug = true
@list_only = false
@urls = [
	'http://www.inzercebyty.cz/byty-1-1-1/?kind=1&region=76', 
	'http://www.inzercebyty.cz/byty-2-1-3/?kind=1&region=76&page=1',
	'http://www.inzercebyty.cz/byty-3-1-5/?kind=1&page=1&region=76',
	'http://www.inzercebyty.cz/byty-4-1-7/?kind=1&page=1&region=76',
	'http://www.inzercebyty.cz/byty-vetsi-nez-4-1-9/?kind=1&page=1&region=76',
]

@detail_url_path = 'table td.item-subject a'

@description = "td.item-note"
@phone_paths = ['td.item-feature']
